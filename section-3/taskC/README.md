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

6. **Compare with Remote Infrastructure**
   - Use `terraform refresh` to update state with real infrastructure.
   - Investigate if resources were changed outside of Terraform (manual changes).

7. **Validate Provider Versions**
   - Confirm provider versions in use match those expected in the codebase.
   - Check for breaking changes in provider or module versions.

8. **Collaborate with Team**
   - Ask teammates if they are aware of any intentional changes or issues.
   - Coordinate to avoid conflicting changes.

9. **Test in a Non-Production Environment**
   - Apply the plan in a staging or test environment to observe the impact safely.

10. **Document Findings and Next Steps**
    - Summarize the root cause of the unexpected diff.
    - Record actions taken and communicate with stakeholders
