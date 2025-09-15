# Task D – Pod in CrashLoopBackOff (Node.js App)
- Identify why the pod keeps crashing
- Ensure logs and probes reveal the root cause
- Recommend better crash handling and probes

## Step 1: Debug Why the Pod Is Down

To debug why the pod is down, follow these steps:

1. **Check Pod Status**
   ```sh
   kubectl get pods
   ```
   Look for pods in `CrashLoopBackOff` or `Error` state.

2. **Inspect Pod Logs**
   ```sh
   kubectl logs <pod-name>
   ```
   The logs will show:
   ```
   Starting app...
   Error: App crashed on purpose!
   ```

3. **Describe the Pod**
   ```sh
   kubectl describe pod <pod-name>
   ```
   This command provides more details about recent restarts and failure reasons.

**Root Cause:**  
The application (`index.js`) throws an uncaught error after 1 second, causing the Node.js process to exit. Kubernetes detects this as a failure and restarts the pod, resulting in a CrashLoopBackOff.

Continue with logs and probes to confirm and document the root cause.

## Using Logs and Probes to Reveal the Root Cause

- **Logs:**  
  You can view the pod logs with:
  ```
  kubectl logs <pod-name>
  ```
  The logs will show:
  ```
  Starting app...
  Error: App crashed on purpose!
  ```

- **Probes:**  
  If liveness or readiness probes were configured, they would fail after the app crashes, confirming the pod is not healthy.

## Recommendations

- **Crash Handling:**  
  Implement proper error handling in the Node.js app to prevent it from crashing on uncaught errors. For example, use a global error handler or avoid throwing unhandled exceptions.

- **Probes:**  
  Add liveness and readiness probes to the deployment to help Kubernetes detect and manage unhealthy pods more effectively.

    > Example Liveness Probe is shown in updated deployment.yaml
