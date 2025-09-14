# Task C – Deploy Kubernetes App with Helm

- Deploy a simple Nginx-based web app using Helm.
- Customize values.yaml, use Ingress + Service.
- Output: chart repo or manifest, values used, explanation.

## Helm Chart Creation Process

1. **Initialize Helm Chart**
	- Ran the following command to create a new Helm chart named `sample-nginx`:
	  ```bash
	  helm create sample-nginx
	  ```
	- This generated the basic Helm chart structure in the `sample-nginx` directory.

2. **Next Steps**
	- Customize the generated chart (edit `values.yaml`, templates, etc.)
	- Configure Ingress and Service as required.
	- Deploy to Kubernetes using Helm.
