# Task A – Production went down
- “App is down in production – what do you do first?”
- Output: write your investigation process step by step.

## Investigation Process

1. **Check Monitoring and Alerts**
   - Review monitoring dashboards (e.g., uptime, error rates, latency).
   - Check for any alerts or notifications from monitoring tools.

2. **Verify the Outage**
   - Attempt to access the application as an end user.
   - Confirm if the issue is global or limited to certain regions/services.

3. **Acknowledge the Incident**
   - Confirm the outage and notify relevant stakeholders and the incident response team.

4. **Check Infrastructure Health**
   - Inspect the status of servers, containers, databases, and network components.
   - Look for failed services, high resource usage, or connectivity issues.

5. **Check Application Logs**
   - Review recent logs for errors, exceptions, or unusual activity.
   - Identify any patterns or spikes in errors.

6. **Review Recent Changes**
   - Check if any deployments, configuration changes, or updates occurred recently.
   - Roll back recent changes if they are suspected to be the cause.

7. **Communicate Status**
   - Provide regular updates to stakeholders and users about the status and progress.

8. **Mitigate and Restore Service**
   - Apply fixes or workarounds to restore service as quickly as possible.
   - Escalate to relevant teams if needed.

9. **Document Findings**
   - Record the root cause, actions taken, and lessons learned for future reference.

10. **Post-Incident Review**
    - Conduct a retrospective to improve processes and prevent future incidents.

---

## Example: App Service Not Available After Latest Helm Update

**Scenario:**  
After deploying a new Helm release, the application service is unavailable.

### Step-by-Step Investigation

1. **Check Monitoring and Alerts**
   - Noticed a spike in error rates (kibana dashboard)

2. **Verify the Outage**
   - Tried accessing the app; received 503 Service Unavailable.
   - Confirmed the issue affects all users.

3. **Acknowledge the Incident**
   - Notified the incident response team and stakeholders about the outage.

4. **Check Infrastructure Health**
   - Ran `kubectl get pods` and saw new pods in CrashLoopBackOff state.
   - Checked node and cluster health; no resource exhaustion detected.

5. **Check Application Logs**
   - Inspected pod logs with `kubectl logs <pod-name>`.
   - Found errors related to missing environment variables.

6. **Review Recent Changes**
   - Confirmed a Helm update was deployed minutes before the outage.
   - Compared Helm values and noticed a misconfigured environment variable.
   - Rolled back to the previous Helm release using `helm rollback`.

7. **Communicate Status**
   - Updated stakeholders about the rollback and ongoing investigation.

8. **Mitigate and Restore Service**
   - After rollback, pods became healthy and service was restored.
   - Monitored for stability.

9. **Document Findings**
   - Root cause: Misconfigured environment variable in Helm values.
   - Actions: Rolled back release, fixed configuration, improved review process.

10. **Post-Incident Review**
    - Scheduled a retrospective to discuss deployment validation and review processes.
