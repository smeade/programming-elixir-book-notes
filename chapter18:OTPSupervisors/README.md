## OTP: Supervisors

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Supervisors

> imagine that instead your application consists of hundreds or thousands of processes, each handling just a small part of a request. If one of those crashes, everything else carries on. You might lose the work it’s doing, but you can design your applications to minimize even that risk. And when that process gets restarted, you’re back running at 100%.

> In the Elixir and OTP worlds, supervisors perform all of this process monitoring and restarting.

### Supervisors and Workers

Supervisor:

* manages one or more worker processes
* process that uses the OTP supervisor behavior
* via Erlang VM's process-linking and monitoring facilities

### Exercise

> Add a supervisor to your stack application. Use iex to make sure it starts the server correctly. Use the server normally, and then crash it (try popping from an empty stack). Did it restart? What were the stack contents after the restart?

Notes:

Instead of using `--sup` flag and creating a new project, I added the `start(_type, _args)` function to the stack application. Also found I had to add `mod: {Stack, []}` to the application configuration.

When defining the child process in `start`, I initially defined it as:

```Elixir
worker(Stack.Server, [1, 2, 3])
```

This resulted in an exception when attempting to start. The reason was that the list `[1, 2, 3]` is parsed as three arguments to `Stack.Server.start_link` and not as a single argument list. The correct definition is:

```Elixir
worker(Stack.Server, [ [1, 2, 3] ])
```

### Managing Process State Across Restarts

* One approach is to use a separate worker process to store state.
* This process should be as simple and bullet proof as possible.
* This process is supervised separately - creating a supervision tree.

Supervision tree:
* Main Supervisor supervises the Stash Worker and a Subsupervisor
* Subsupervisor supervises our worker

