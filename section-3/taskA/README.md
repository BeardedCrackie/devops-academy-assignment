# Task A – Production went down
- “App is down in production – what do you do first?”
- Output: write your investigation process step by step.

## Investigation Process

1. **Check Monitoring and Alerts**
   - Review monitoring dashboards (e.g., uptime, error rates, latency).
   - Check for any alerts or notifications from monitoring tools.

3. **Verify the Outage**
   - Attempt to access the application as an end user.
   - Confirm if the issue is global or limited to certain regions/services.

2. **Acknowledge the Incident**
   - Confirm the outage and notify relevant stakeholders and the incident response team.

5. **Check Infrastructure Health**
   - Inspect the status of servers, containers, databases, and network components.
   - Look for failed services, high resource usage, or connectivity issues.

4. **Check Application Logs**
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
