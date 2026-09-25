# Concurrency

- Use this lens only when the code runs threads, asynchronous tasks, or subprocesses that share state. Sequential code has no concurrency findings.
- Establish the owner and synchronization of shared mutable state. Trace an actual interleaving that races, deadlocks, or applies a stale decision. Do not report a race that needs a second user or process the program does not have.
- Follow tasks and subprocesses through shutdown. Their lifetime should agree with the work that owns them. Use a focused interleaving check when it would settle a concrete concern.
