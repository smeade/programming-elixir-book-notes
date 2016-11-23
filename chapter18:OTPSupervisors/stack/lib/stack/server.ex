defmodule Stack.Server do
  use GenServer

  # External API
  def start_link(current_stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  # GenServer implementation
  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, value}, current_stack) do
    { :noreply, [value | current_stack] }
  end

  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
