defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, value}, current_stack) do
    { :noreply, [value | current_stack] }
  end
end
