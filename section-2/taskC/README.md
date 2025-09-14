# Task C – Docker Build Fails (no space left on device)
- Diagnose the CI disk full issue
- Propose temporary and permanent fixes
- Define monitoring measures to detect/prevent it

## Investigation: Diagnosing "No Space Left on Device" in CI

1. **Check CI Build Logs**  
   Review the CI logs to identify at which step the "no space left on device" error occurs (e.g., during `npm install` or `COPY`).

2. **Inspect Disk Usage on CI Runner**  
   Add commands like `df -h` and `du -sh /*` in your CI job before and after each build step to monitor disk usage.

3. **Check Docker System Usage**  
   On self-hosted runners, run:
   ```sh
   docker system df
   docker system prune -af
   ```
   to see and clean up unused images, containers, and volumes.

4. **Review Workspace and Cache Directories**  
   Large files or caches from previous builds may fill up disk space. Clean up unnecessary files or limit cache retention.

## Temporary and permanent fixes

1. **Clean Up Temporary and Unused Files and Directories**  
   - If there are any temporary and unused files delete them manually.
   - For example, run:
     ```sh
     rm -rf /tmp/*
     ```
   - This helps free up space that may be consumed by leftover files from previous jobs

2. **Increase Disk Space**  
   If there is need, increase the disk size of your CI runner or use ephemeral runners that start with a clean state.

3. **Increase Disk Space**  
   If there is need, increase the disk size of your CI runner or use ephemeral runners that start with a clean state.

## Permanent fixes

1. **Optimize Dockerfile**  
   - Minimize layers and files copied.
   - Use `.dockerignore` to exclude unnecessary files from the build context.
   - Check for Large Dependencies: `npm install` may pull large packages. Audit your dependencies and remove unused ones.

2. **Audit Pipelines for Cleanup**  
   - Ensure each CI agent or runner is configured to clean up files, containers, and caches after the job completes.
   - Implement post-job cleanup steps in your pipeline configuration to remove build artifacts and temporary files.
   - Use Ephemeral runners that start with a clean state and after pipeline runs destroy them.

## Dockerfile Optimization Notes

- **Use of Official Node.js Image:**  
  Switched from `ubuntu:20.04` with manual Node.js installation to `node:20-slim`, reducing image size and build time.

- **Selective File Copy:**  
  Only `package*.json` files are copied first to leverage Docker layer caching, so dependencies are only reinstalled when they change.

- **Efficient Dependency Installation:**  
  Used `npm ci --only=production` for faster, reproducible, and production-focused installs.

- **Reduced Build Context:**  
  By using a `.dockerignore` file (recommended), unnecessary files are excluded from the build context, further reducing image size and disk usage.

- **Optional: Use Multi-Stage Builds:**  
  Multi-stage builds allow you to separate build dependencies from the final image, keeping the production image as small as possible.  
  Example:
  ```dockerfile
  FROM node:20-slim AS builder
  WORKDIR /app
  COPY package*.json ./
  RUN npm ci --only=production
  COPY . .

  FROM node:20-slim
  WORKDIR /app
  COPY --from=builder /app ./
  CMD ["node", "index.js"]
  ```
  This approach ensures only the necessary files and production dependencies are included in the final image, further reducing size and potential disk
