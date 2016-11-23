## Nodes

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

A node:
* is a running Erlang VM
* like a little OS
* manages events, scheduling, memory, etc.
* manages interprocess communication.

A node:
* connects to other Nodes
* provides services across connections just as it provides locally

### Naming Nodes and Processes

```Elixir
$ iex --name scott@work.local
Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(scott@work.local)1>
```

```Elixir
work:chapter16:Nodes smeade$ iex --sname node_one
Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(node_one@work)1> Node.list
[]
iex(node_one@work)2> Node.list
[:node_two@work]
iex(node_one@work)3> func = fn -> IO.inspect Node.self end
#Function<20.52032458/0 in :erl_eval.expr/5>
iex(node_one@work)4> spawn(func)
:node_one@work
#PID<0.94.0>
iex(node_one@work)5> Node.spawn(:"node_one@work", func)
:node_one@work
#PID<0.96.0>

# Output appears here on node_one because
# the node_one hierarchy has the group leader
# which determines where IO.puts sends its output.
iex(node_one@work)6> Node.spawn(:"node_two@work", func)
:node_two@work
#PID<9267.98.0>
```

#### Exercise

```Elixir
iex(node_one@work)2> Node.spawn(:"node_one@work", fun)
README.md
#PID<0.90.0>
iex(node_one@work)3> Node.spawn(:"node_two@work", fun)
#PID<9415.91.0>
.ansible,.atom,.babel.json,.bash_history,.bash_profile..
```

### Nodes, Cookies, and Security

* nodes compare the remote node's cookie to its own cookie
* when configuring a distributed Elixir system, you must create a cookie that all nodes use

### Naming Your Processes

> If you want to register a callback process on one node and an event- generating process on another, just give the callback PID to the generator.
> The callback on the other node can look up the generator by name, using the PID that comes back to send messages to it.

```Elixir
:global.register_name(:ticker, pid)
```

```Elixir
send :global.whereis_name(:ticker), { :register_client, client_pid }
```

### Nodes Are the Basis of Distribution

> We’ve seen how we can create and interlink a number of Erlang virtual machines, potentially communicating across a network. This is important, both to allow your application to scale and to increase reliability. -- Dave Thomas
