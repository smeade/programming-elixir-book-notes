## OTP: Servers

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

OTP bundle includes:
* Erlang
* a database (Mnesia)
* bunch of libraries

### Definitions

Applications: an application consists of one or more processes.
Behaviors: a small number of OTP conventions followed by processes.
GenServer: a server behavior.

### An OTP Server

> When we write an OTP server, we write a module containing one or more callback functions with standard names. OTP will invoke the appropriate callback to handle a particular situation.

State:
* handler functions get passed current state as last param
* handler functions return a potentially updated state, which is passed to the next request handler

### Our First OTP server

#### Exercise: OTP-Servers-1

```Elixir
defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end
end
```

```Elixir
work:stack smeade$ iex -S mix
Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Compiling 2 files (.ex)
Generated stack app
Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> { :ok, pid } = GenServer.start_link(Stack.Server, [1,2,3])
{:ok, #PID<0.145.0>}
iex(2)> GenServer.call(pid, :pop)
1
iex(3)> GenServer.call(pid, :pop)
2
iex(4)> GenServer.call(pid, :pop)
3
```

### Tracing a Server’s Execution

Enable tracing using the `debug` option:

```Elixir
{:ok,pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
```

### GenServer Callbacks

OTP protocol expects implementations of a number of callback functions. `use GenServer` created default implementations which you can then override.

The six GenServer callbacks are:
* `init(start_arguments)`
* `handle_call(request, from, state)`
* `handle_cast(request, state)`
* `handle_info(info, state)`
* `terminate(reason, state)`
* `code_change(from_version, state, extra)`
* `format_status(reason, [pdict, state])`

### Naming a Process

```Elixir
iex> { :ok, pid } = GenServer.start_link(Sequence.Server, 100, name: :seq) {:ok,#PID<0.58.0>}
iex> GenServer.call(:seq, :next_number)
100
```

### Tidying Up the Interface

Create functions that serve as an external API. These are wrappers around the GenServer calls. e.g.:

```Elixir
# External API
def start_link(current_number) do
  GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
end

def next_number do
  GenServer.call __MODULE__, :next_number
end

def increment_number(delta) do
  GenServer.call __MODULE__, { :increment_number, delta }
end
```

### OTP GenServer

> An OTP GenServer is just a regular Elixir process in which the message handling has been abstracted out. The GenServer behavior defines a message loop internally and maintains a state variable. That message loop then calls out to various functions that we define in our server module: handle_call, han- dle_cast, and so on. -- Dave

