defmodule Sequence.Server do
  use GenServer

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

  # Implementation
  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number + 1, current_number + 1 }
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number }
  end

  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, current_number + delta}
  end
end
