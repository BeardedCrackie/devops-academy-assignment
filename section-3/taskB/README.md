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
