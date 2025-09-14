# Task A – 502 Bad Gateway (Nginx + Node.js)
- Identify the root cause of the 502 error
- Apply a fix (update port config)
- Explain how to prevent this in production

## Identify the root cause of the 502 error

An HTTP 502 Bad Gateway error signifies that a server acting as a gateway or proxy received an invalid response from an upstream server. This prevents the request from being completed successfully.

Common causes include:
- The upstream server is down or unreachable.
- Network errors between the proxy and upstream server.
- Misconfigured firewall or server settings.
- Overloaded upstream server.

When this error occurs, users typically see a message like "502 Bad Gateway".

> **Note:**  
> In this case, the root cause is a misconfiguration on the proxy side: Nginx is forwarding requests to port `8080` instead of the correct port `80` where the Node.js application is running.

## Fixing the Issue

To resolve the 502 Bad Gateway error, the port configuration in the `nginx.conf` file was updated. Previously, Nginx was set to forward requests to port `8080`, which was incorrect. The configuration was changed to forward requests to the correct port (`80`), where the Node.js application is actually running.

**Steps taken:**
1. Opened the `nginx.conf` file.
2. Located the `proxy_pass` directive.
3. Changed the port from `8080` to `80`.
4. Restarted the Nginx service to apply the changes.

This fix ensures that Nginx correctly forwards requests to the running Node.js application, resolving the 502 Bad Gateway error.

## How to Prevent This in Production

To avoid similar issues in production, configuration files should not use hardcoded port numbers. Instead, ports should be loaded dynamically using environment variables. This makes the setup more flexible and less error-prone, especially when deploying to different environments.

**Recommended approach:**
- Use environment variables to define the application port.
- Template your configuration files (e.g., `nginx.conf.template`) with placeholders for ports.
- At container startup, use a tool like `envsubst` to substitute environment variables into the config file:
  ```sh
  envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
  ```
- Start Nginx after the config is generated.


This approach ensures that your configuration always matches the actual runtime environment, reducing the risk of misconfiguration and 502 Bad Gateway errors. Also, environment variable files (like `.env`) can be added separately, and Docker Compose can reference those values for even more flexible configuration.

> **Note:**  
> There is an example of the recommended approach for production in this repo.  
> Check out these files:
> - `nginx.conf.template` (uses env variables for dynamic config)
> - `docker-compose.env.yml` (compose file that contains ENV definitions and references them into nginx with new entrypoint)

