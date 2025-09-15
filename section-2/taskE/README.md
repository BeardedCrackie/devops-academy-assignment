# Task E – Secret Not Mounted as ENV (Kubernetes)
- Discover why DB_PASSWORD is missing at runtime
- Fix namespace/applications mismatch or missing resource
- Demonstrate debugging (without printing secret in logs)

## Potential Problems

### 1. **Namespace Mismatch**
- Secret and deployment are in different namespaces
- Secret created in `default` namespace but deployment in another namespace
- Missing namespace specification in YAML files

### 2. **Secret Resource Issues**
- Secret doesn't exist in the cluster
- Secret was deleted after deployment creation
- Secret created after pods were already running
- Incorrect secret name reference in deployment

### 3. **Secret Key Mismatch** (not this case)
- Deployment references wrong key name (e.g., `password` vs `db_password`)
- Secret contains different key names than expected
- Case sensitivity issues in key names
- Special characters in secret key names

### 4. **Deployment Configuration Errors** (not this case)
- Missing `secretKeyRef` configuration
- Incorrect `valueFrom` syntax
- Wrong container name in multi-container pod
- Environment variable name typo (`DB_PASSWORD` vs `DATABASE_PASSWORD`)

### 5. **Pod Lifecycle Issues**
- Pods started before secret was created
- Deployment not restarted after secret creation/update
- Old pods still running with outdated configuration
- Rolling update not triggered properly

### 6. **RBAC Permissions**
- Service account lacks permission to access secrets
- Secret not readable by the pod's service account
- Cluster-level RBAC policies blocking secret access

### 7. **Secret Content Issues**
- Secret created without proper base64 encoding
- Empty secret values
- Secret data corruption
- Invalid characters in secret values

### 8. **Kubernetes Resource Limits**
- Resource quotas preventing pod creation
- Node selector preventing pod scheduling
- Insufficient cluster resources

### 9. **Application-Level Issues**
- Application not reading environment variables correctly
- Environment variable overridden by application code
- Container entrypoint script clearing environment variables
- Application expecting different variable names

### 10. **Timing Issues**
- Race condition between secret creation and pod startup
- Init containers affecting environment variable availability
- Application starting before all environment variables are loaded

## Debugging Commands (Safe - No Secret Exposure)

```bash
# Check secret exists and in correct namespace
kubectl get secrets --all-namespaces | grep db-secret

# Verify secret structure (keys only)
kubectl get secret db-secret -o jsonpath='{.data}' | jq 'keys'

# Check deployment env configuration
kubectl get deployment <name> -o jsonpath='{.spec.template.spec.containers[*].env}'

# Verify pod has environment variable (without value)
kubectl exec <pod-name> -- env | grep DB_PASSWORD || echo "Missing"

# Check pod events for errors
kubectl describe pod <pod-name>

# Verify service account permissions
kubectl auth can-i get secrets --as=system:serviceaccount:<namespace>:<service-account>
```
