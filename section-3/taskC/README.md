# Task C – Terraform shows large infrastructure diff unexpectedly
- Terraform plan shows major changes no one expected.
- What steps would you take before approving/applying?


## Investigation Process

1. **Review the Terraform Plan Output**
   - Carefully examine the proposed changes in the Terraform plan.
   - Identify which resources are being created, modified, or destroyed.

2. **Check for Uncommitted or Local Changes**
   - Ensure your working directory is clean (`git status`).
   - Confirm that the Terraform state and configuration files match the committed code.

3. **Validate Terraform State Consistency**
   - Run `terraform state list` and compare with your configuration.
   - Check for any drift between the actual infrastructure and the state file.

4. **Review Recent Code Changes**
   - Inspect recent commits and pull requests for changes to Terraform files.
   - Look for refactoring, provider upgrades, or module updates.

5. **Check Backend and State Locking**
   - Ensure the correct backend is configured and state locking is working.
   - Verify you are using the correct workspace/environment.

6. **Validate Provider Versions**
   - Confirm provider versions in use match those expected in the codebase.
   - Check for breaking changes in provider or module versions.

7. **Compare with Remote Infrastructure**
   - Use `terraform refresh` to update state with real infrastructure.
   - Investigate if resources were changed outside of Terraform (manual changes).

8. **Collaborate with Team**
   - Ask teammates if they are aware of any intentional changes or issues.
   - Coordinate to avoid conflicting changes.

9. **Test in a Non-Production Environment**
   - Apply the plan in a staging or test environment to observe the impact safely.

10. **Document Findings and Next Steps**
    - Summarize the root cause of the unexpected diff.
    - Record actions taken and communicate with stakeholders.

---

## Example: Operator Recreated Database from Backup via AWS Console

**Scenario:**  
An operator manually deleted the existing database and recreated it from a backup using the AWS Management Console. Later, running `terraform plan` shows Terraform wants to recreate the database resource, even though the data appears unchanged.

### Step-by-Step Investigation Using the Checklist

1. **Review the Terraform Plan Output**
   - The plan shows the database resource will be recreated.
   - Resource IDs or metadata do not match what Terraform expects.

2. **Check for Uncommitted or Local Changes**
   - `git status` shows no uncommitted changes.
   - Terraform files match the committed code.

3. **Validate Terraform State Consistency**
   - `terraform state list` does not include the newly created database.
   - Confirms state file is unaware of the manual replacement.

4. **Review Recent Code Changes**
   - No recent changes to database resources in code or pull requests.

5. **Check Backend and State Locking**
   - Backend configuration and workspace are correct.

6. **Validate Provider Versions**
   - Provider versions are consistent with the codebase.

7. **Compare with Remote Infrastructure**
   - `terraform refresh` updates state, but the new database is still unmanaged.
   - Confirmed with AWS Console that the database exists but is not tracked by Terraform, in AWS CloudTrail I was able to find manual change by cooworker.

8. **Collaborate with Team**
   - Asked the team and discovered an operator recreated the database from backup for recovery purposes.

9. **Test in a Non-Production Environment**
   - Applied the plan in staging; confirmed Terraform will attempt to recreate or modify the database to match the code.

10. **Document Findings and Next Steps**
    - Root cause: Manual replacement of the database not reflected in Terraform state.
    - Actions: Communicated the risk of manual changes, imported the new database into Terraform state (using `terraform import`) or let Terraform recreate if needed, and updated documentation to reinforce IaC
