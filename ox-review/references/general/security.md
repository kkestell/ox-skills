# Security

- The threats that matter are secrets committed to the repository or written to logs and output, and operations that could delete or overwrite the user's own data. Tie a finding to a concrete input or path.
- Check injection, path traversal, and permission boundaries only when the code accepts input from someone other than the user, such as a network service or a shared file.
- Do not report hardening, resource limits, or validation of the user's own input as security findings.
