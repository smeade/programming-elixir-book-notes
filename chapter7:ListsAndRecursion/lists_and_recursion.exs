defmodule ExList do
  def all?([], _), do: true
  def all?([head | tail], fun) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end

  def each([], _), do: []
  def each([head | tail], fun) do
    [fun.(head)] ++ each(tail, fun)
  end

  def filter([], _), do: []
  def filter([head | tail], fun) do
    if fun.(head) do
      [head] ++ filter(tail, fun)
    else
      [] ++ filter(tail, fun)
    end
  end
end
