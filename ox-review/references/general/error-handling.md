# Error handling

- Crashing with a clear message is an acceptable response to a failure the user can fix, such as a missing file or a bad argument. Do not ask for recovery, retries, or fallbacks unless the program must keep running through that failure.
- Check discarded, flattened, or overly broad errors for a real lost failure or lost context. An error type or classification needs a caller that acts on the distinction; otherwise a plain message is enough.
- Flag validation of input the program itself produced, and checks for states the code cannot reach, as code to remove.
