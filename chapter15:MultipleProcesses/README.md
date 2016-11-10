## Working with Multiple Processes

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

> One of Elixir’s key features is the idea of packaging code into small chunks that can be run independently and concurrently.
If you’ve come from a conventional programming language, this may worry you. Concurrent programming is “known” to be difficult, and there’s a performance penalty to pay when you create lots of processes.
Elixir doesn’t have these issues, thanks to the architecture of the Erlang VM on which it runs.

> In fact, Elixir developers are so comfortable creating new processes, they’ll often do it at times when you’d have created an object in a language such as Java. -- Dave Thomas

### Actor Model

* An actor is "an independent process that shares nothing with any other process."

You can:
* spawn processes
* `send` them messages
* `receive` messages back

Elixir processes are:
* _not_ operating system processes
* are fast and lightweight via Erlang process support
* normally created in the hundreds, thousands or hundreds of thousands.

### A Simple process

```Elixir
defmodule SpawnBasic do
  def greet do
    IO.puts "Howdy!"
  end
end
```

#### Trying it out:
```Elixir
Interactive Elixir (1.3.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> c "spawn-basic.ex"
[SpawnBasic]

# as a regular function
iex(2)> SpawnBasic.greet
Howdy!
:ok

# as a separate process
iex(3)> spawn(SpawnBasic, :greet, [])
Howdy!
#PID<0.89.0>
```

`spawn`:
* creates a new process
* is async - don't know when it will run
* use messages to synchronize processes
* returns a PID (does not return pid when complete, but when started)


#### Sending messages between processes

messages:
* sent via `send` function
* convention is to send atoms and tuples
* are awaited via `receive`

In this example from the book:
* `receive` waits for a message
* does pattern matching on the message

```Elixir
defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
    end
  end
end

# client
pid = spawn(Spawn1, :greet, [])
send pid, {self, "Everyone!"}

receive do
  {:ok, message} ->
    IO.puts message
end
```

#### Handling Multiple Messages

* once `greet` function processed the `receive`, it exits
* so the second `receive` just hanges
* one way to handle that: timeout if no response received

```Elixir
receive do
  {:ok, message} ->
    IO.puts message
  after 500 ->
    IO.puts "The greeter has gone away"
end
```

```Elixir
iex(1)> c "spawn3.exs"
Hello, World!
The greeter has gone away
[Spawn3]
```

#### Recursion, Looping, and the Stack

* timeout is not ideal, obviously
* instead we could loop - but Elixir does not have loops
* instead use tail recursion so that each time it receives a message it processes the message and then calls itself, thereby awaiting another message

```Elixir
defmodule Spawn4 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
        greet
    end
  end
end
```

#### Tail call optimization

>  If the last thing a function does is call itself, there’s no need to make the call. Instead, the runtime simply jumps back to the start of the function. If the recursive call has arguments, then these replace the original parameters. -- Dave Thomas

#### Process Overhead

Elixir processes are very low overhead. [spawn/chain.exs](spawn/chain.exs) is an example that can spin up `n` processes, each sequentially calling the next pid.

#### exercises

**"Run this code on your machine..."**

Where Dave reports that his 2011 MacBook Air (2.13GHz Core 2 Duo and 4GB of RAM) ran a million processes (sequentially) in just over 5 seconds, it took over 7 seconds on my MacBook Pro Retina, 15-inch, Late 2013 2.3 GHz Intel Core i7 with 16 GB 1600 MHz DDR3 memory. Wonder why?

```
work:spawn smeade$ elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(1000000)"
{7186865, "Result is 1000000"}
```

**"Write a program that spawns two processes..."**

I wrote [myspawn.exs](spawn/myspawn.exs). Playing around with changes to myspawn.exs I:

* spawned three processes
* experimented with how and when the processes receive messages and send responses
* experimented with how and when the initial process sends messages and handles responses
* adjusted the spawned processes to respond to either the calling process or some other process. self spawns pid1 and pid2. When self sends a message to pid2, it has pid2 send a message to pid1 and pid1 handles the response.

#### When Processes Die / Linking Processes

* By default, nothing gets notified when a process dies.
* `spawn_link` spawns a process and links it to the caller in one operation

```Elixir
  spawn_link(Link2, :sad_function, [])
```

> What if you want to handle the death of another process? Well, you probably don’t want to do this. Elixir uses the OTP framework for constructing process trees, and OTP includes the concept of process supervision. An incredible amount of effort has been spent getting this right, so I recommend using it most of the time.  -- Dave Thomas

But we can handle exit signals, like so:

```Elixir
  Process.flag(:trap_exit, true)
```

Experimenting with [link3.exs](spawn/link3.exs):

* Without `Process.flag(:trap_exit, true)` in place:
  * `exit(:normal)` does not cause the program to EXIT
  * `exit(:anythingelse)` does cause the program to EXIT

* With `Process.flag(:trap_exit, true)` in place:
  * the `exit` is received as a message of
  * `{:EXIT, #PID<0.76.0>, :normal}` or
  * `{:EXIT, #PID<0.76.0>, :whatever}`...

#### Process Monitoring

* monitoring spawns another process and gets notified of its termination
* one-way only
* monitor receives `:DOWN` message upon exit or failure

```Elixir
res = spawn_monitor(Monitor1, :sad_function, [])
```

#### exercises

Turns out I already did some of these exercises on my own earlier in order to experiment and learn more. Onward!

#### Parallel Map

Apply a function to each element in a collection, but process each element in a separate process. See [pmap.exs](spawn/pmap.exs).

```Elixir
defmodule Parallel do
  def pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
         spawn_link fn -> (send me, { self, fun.(elem) }) end
       end)
    |> Enum.map(fn (pid) ->
         receive do { ^pid, result } -> result end
       end)
  end
end
```

Notes:
* Note the assignment of `me = self`, otherwise using `self` in the spawn_link would return the spawned process itself, not the parent or `pmap` function.
* Note the use of `^pid` instead of `_pid` or `pid`. This ensures that the receive functions are created in the order the pids from the spawn_links are generated. The matching block of the receives will each have the pid value in the param.

#### A Fibonacci Server

Dave's Fibonacci server code is intended to demonstrate:

* the scheduler `run` function
* handling of concurrent processing of spawned processes across cores
* the passing of messages between a scheduler and a server

This code and the Fibonacci Server message flow diagram in Dave's book is a great reminder of thinking in terms of messages. Interestingly, object-orientated code is also intended to be one in which passing messages between objects is the primary design consideration. Yet somewhere along the way the focus moved from the messages to the objects themselves.

Functional programming and Elixir make the need for, and design of, message handling explicit and forefront.
