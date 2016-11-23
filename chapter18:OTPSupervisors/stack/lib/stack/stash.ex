defmodule Stack.Stash do
  use GenServer

  # External API
  def start_link(current_value) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_value)
  end
  def save_value(pid, new_value) do
    GenServer.cast pid, {:save_value, new_value}
  end
  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  # GenServer implementation
  def handle_call(:get_value, _from, current_value) do
    { :reply, current_value, current_value }
  end
  def handle_cast({:save_value, new_value}, _current_value) do
    { :noreply, new_value }
  end
end
