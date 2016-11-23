defmodule Stack.Supervisor do
  use Supervisor
  def start_link(initial_value) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [])
    start_workers(sup, initial_value)
    result
  end
  def start_workers(sup, initial_value) do
    # Manually start the stash worker
    {:ok, stash } =
      Supervisor.start_child(sup, worker(Stack.Stash, [initial_value]))
    # and then the subsupervisor for the sequence server
    Supervisor.start_child(sup, supervisor(Stack.SubSupervisor, [stash]))
  end
  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
