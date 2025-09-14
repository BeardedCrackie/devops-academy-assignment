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
