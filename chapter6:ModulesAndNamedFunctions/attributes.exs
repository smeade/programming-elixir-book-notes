defmodule Example do
  @author "Dave"

  def get_author, do: @author
end
IO.puts "Example by #{Example.get_author}"
