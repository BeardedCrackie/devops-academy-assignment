# Task B – CI/CD pipeline is stuck
- Jenkins/GitLab CI pipeline is hanging for 30+ min.
- How would you debug it? What logs would you check? How to unblock it?

## Step-by-Step Investigation (using checklist)

1. **Check Monitoring and Alerts**
   - Review CI/CD system dashboards for stuck jobs, queue length, or resource exhaustion.
   - Check for any alerts about agent/node failures or high load.

2. **Verify the Outage**
   - Open the pipeline/job UI to confirm which stage or step is hanging.
   - Check if other pipelines are also affected or if it’s isolated.

3. **Acknowledge the Incident**
   - Notify the team and stakeholders about the pipeline issue - depends on responsibilities

4. **Check Infrastructure Health**
   - Inspect build agents/runners: Are they online and healthy?
   - Check server/container resource usage (CPU, memory, disk, network).
   - For Kubernetes-based runners, check pod status (`kubectl get pods`).

5. **Check Application Logs**
   - Review pipeline logs in Jenkins/GitLab UI to identify the last successful step.
   - Check agent/runner logs for errors (e.g., `/var/log/jenkins/jenkins.log`, GitLab Runner logs).
   - Look for stuck processes, network timeouts, or external dependency issues.

6. **Review Recent Changes**
   - Check if there were recent updates to pipeline scripts, plugins, or runner images.
   - Review recent commits or configuration changes that could affect the pipeline.

7. **Communicate Status**
   - Update stakeholders on findings and estimated resolution time.

8. **Mitigate and Restore Service**
   - Cancel the stuck job and retry the pipeline.
   - Restart affected agents/runners if unresponsive.
   - If a specific step is problematic, skip or patch it temporarily.
   - Escalate to infrastructure or DevOps team if deeper issues are found.

9. **Document Findings**
   - Record the root cause (e.g., agent crash, infinite loop in script, external service timeout).
   - Note actions taken and any fixes applied.

10. **Post-Incident Review**
    - Review pipeline design and agent health monitoring.
    - Implement improvements (timeouts, better error handling, resource limits) to prevent recurrence.

---

## Example: GitLab CI Pipeline Stuck Due to Missing Artifact

**Scenario:**  
A GitLab CI pipeline is stuck because it cannot download a specific version of an artifact that was deleted from the artifact server.

### Step-by-Step Investigation

1. **Check Monitoring and Alerts**
   - Noticed a pipeline job running much longer than usual.
   - No infrastructure alerts, but pipeline queue is growing.

2. **Verify the Outage**
   - Opened the GitLab pipeline UI and identified the job stuck at the "download artifact" step.
   - Other pipelines using the same artifact version are also stuck.

3. **Acknowledge the Incident**
   - Notified the development and DevOps teams about the pipeline issue.

4. **Check Infrastructure Health**
   - Verified that GitLab runners are healthy and have network connectivity.
   - No resource exhaustion on runners or GitLab server.

5. **Check Application Logs**
   - Reviewed the job logs in GitLab UI:
     - Found repeated attempts to download the artifact, ending with errors like `404 Not Found`.
   - Checked GitLab Runner logs for network or permission issues—none found.

6. **Review Recent Changes**
   - Confirmed no recent changes to the pipeline script or runner configuration.
   - Discovered that the artifact retention policy was recently changed, and old artifacts were deleted.

7. **Communicate Status**
   - Updated stakeholders about the root cause: missing artifact due to deletion.

8. **Mitigate and Restore Service**
   - Stopped the stuck jobs.
   - Rebuilt the missing artifact and uploaded it to the artifact server.
   - Restarted the affected pipelines, which then completed successfully.
   - Reviewed and updated artifact retention policies to prevent accidental deletion.

9. **Document Findings**
   - Root cause: Artifact required by the pipeline was deleted due to retention policy.
   - Actions: Rebuilt artifact, updated retention policy, communicated changes to the team.

10. **Post-Incident Review**
    - Scheduled a review to improve artifact management and retention policy awareness.
    - Added monitoring for artifact availability and pipeline
