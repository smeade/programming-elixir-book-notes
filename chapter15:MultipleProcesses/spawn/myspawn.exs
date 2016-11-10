defmodule MySpawn do
  # process to spawn
  # sends the token back
  def flintstone do
    receive do
      { :ok, sender, token } ->
        IO.puts "flintstone ok: #{inspect self} #{inspect sender} #{token}"
        flintstone
      {sender, token, pause} ->
        IO.puts "flintstone: #{inspect self} #{inspect sender} #{token}"
        :timer.sleep(pause)
        send sender, { :ok, self, token }
        flintstone
    end
  end

  def receive_messages do
    receive do
      {:ok, pid, token} ->
        IO.puts "pid reply: #{inspect self} #{inspect pid} #{token}"
    end

    receive do
      {:ok, pid, token} ->
        IO.puts "pid reply: #{inspect self} #{inspect pid} #{token}"
      after 100 ->
        IO.puts "flintstone has gone away"
    end

    receive do
      {:ok, pid, token} ->
        IO.puts "pid reply: #{inspect self} #{inspect pid} #{token}"
      after 100 ->
        IO.puts "flintstone has gone away"
    end
  end

  def run do
    # client
    # Write a program that spawns two processes and
    # then passes each a unique token (for example, “fred” and “betty”)
    pid1 = spawn_link(MySpawn, :flintstone, [])
    pid2 = spawn_link(MySpawn, :flintstone, [])
    pid3 = spawn_link(MySpawn, :flintstone, [])

    send pid1, {self, "fred", 1}
    send pid2, {self, "betty", 1}
    send pid3, {self, "barney", 1}
    #
    # :timer.sleep(500)

    receive_messages
  end
end
