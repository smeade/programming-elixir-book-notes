defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
      fn (_, send_to) ->
        # spawn a new process that runs the counter function
        # the value spawn returns is the PID of the newly
        # created process, which becomes the accumulator's value
        # for the next iteration
        spawn(Chain, :counter, [send_to])
      end

    send last, 0  # send zero to last process to start the count

    receive do    # and wait for the result to come back to us
      final_answer when is_integer(final_answer)  ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end
