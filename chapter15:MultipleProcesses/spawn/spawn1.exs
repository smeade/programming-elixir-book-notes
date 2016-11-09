#---
# Copied from "Programming Elixir 1.3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir13 for more book information.
#---
defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, { :ok, "Hello, #{msg}" }
      greet
    end
  end
end

# client
pid = spawn(Spawn1, :greet, [])
send pid, {self, "Everyone!"}
send pid, {self, "Everyone else!"}

receive do
  {:ok, message} ->
    IO.puts message
end

receive do
  {:ok, message} ->
    IO.puts message
end
