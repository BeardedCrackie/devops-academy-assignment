# Task B – Terraform Error: Error locking state
- Explain the locking error and why it happens
- Implement short-term and long-term fixes (e.g., DynamoDB table)
- Outline team-safe Terraform workflows

## What is the "locking error"?

The "locking error" in this context is **not** a direct error message from Terraform (like `Error: Error locking state`).  
Instead, it refers to a **logical problem**: when no state locking is configured (no S3 object lock or other lock mechanism in the backend), Terraform allows multiple users to make changes at the same time. This can lead to:

- State file corruption
- Lost or conflicting infrastructure changes
- Difficult-to-debug issues in team environments

## Why does this happen?

- By default, the S3 backend does **not** provide state locking.
- Without a lock, Terraform does **not** prevent concurrent operations.
- There is **no warning or error** from Terraform about missing locking—this is a silent risk.

## Short-term fix

- Communicate with your team to ensure only one person runs Terraform at a time.

## Long-term fix

- Enable S3 Object Locking for your state bucket to provide state locking.
- Update your backend configuration to use S3 locking features.
- This enables safe, automatic locking and prevents concurrent state modifications.

> **Note:**  
> DynamoDB-based locking is deprecated. Use S3 Object Locking for new deployments.

## Team-safe Terraform workflow

1. Use S3 backend **with** S3 Object Locking enabled for state locking.
2. Coordinate changes using pull requests and code reviews.
3. Never manually edit the state file.

> **Note:**  
> Never manually edit the state file.

> **Note:**  
> The absence of locking is a logical error that can lead to misuse and problems in team environments, even though Terraform does not display an explicit error.