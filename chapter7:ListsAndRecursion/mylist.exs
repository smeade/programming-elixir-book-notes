defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]) do
    IO.puts("1 + len(#{inspect(tail)})")
    1 + len(tail)
  end

  def add_1([]),               do: []
  def add_1([ head | tail ]),  do: [ head+1 | add_1(tail) ]

  def square([]),               do: []
  def square([ head | tail ]),  do: [ head*head | square(tail) ]

  def map([], _func),             do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

  def sum(list), do: _sum(list, 0)
  defp _sum([], total),              do: total
  defp _sum([ head | tail ], total), do: _sum(tail, head+total)

  def sum2([]), do: 0
  def sum2([ head | tail ]), do: head + sum2(tail)

  def reduce([], value, _) do
    value
  end
  def reduce([ head | tail ], value, func) do
    reduce(tail, func.(head, value), func)
  end

  # Write a mapsum function that takes a list and a function.
  # It applies the function to each element of the list and then sums the result.
  def mapsum([], _func), do: 0
  def mapsum([ head | tail ], func) do
    func.(head) + mapsum(tail, func)
  end

  # Write a max(list) that returns the element with the maximum value in the list.
  # (This is slightly trickier than it sounds.)
  def max([]),  do: nil
  def max([x]), do: x
  def max([ head | tail ]), do: Kernel.max(head, max(tail))

  # Write a function MyList.span(from, to) that returns a list of the numbers
  # from from up to to.

  # stop recursion when from > to
  def span(from, to) when from > to, do: []
  # create list with from at head and tail made of
  # recursive calls to span
  def span(from, to), do: [ from | span(from + 1, to) ]
end
