defmodule Stack.Server do
  use GenServer

  # External API
  def start_link(stash_pid) do
    {:ok, _pid} =
      GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  # GenServer implementation
  def init(stash_pid) do
    current_value = Stack.Stash.get_value stash_pid
    { :ok, {current_value, stash_pid} }
  end
  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    { :reply, head, {tail, stash_pid} }
  end
  def handle_cast({:push, value}, {current_stack, stash_pid}) do
    # String.to_integer(value) so that we can force a failure that exits
    # Stack.Server.push "nan"
    { :noreply, {[String.to_integer(value) | current_stack], stash_pid} }
  end
  def terminate(_reason, {current_value, stash_pid}) do
    Stack.Stash.save_value stash_pid, current_value
  end

  def format_status(_reason, [ _pdict, state ]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
