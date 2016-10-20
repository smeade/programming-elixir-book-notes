defmodule Chop do

  def guess(x, low..high) do
    # get the midpoint of range
    midpoint = div(low+high, 2)
    IO.puts "Is it #{midpoint}?"

    # make another guess at the midpoint of the range
    next_guess(x, midpoint, low..high)
  end

  def next_guess(x, guess, low..high)
    when guess == x,
    do: "Yes, it is #{x}"

  def next_guess(x, guess, low..high)
    when guess < x,
    do: guess(x, guess+1..high)

  def next_guess(x, guess, low..high)
    when guess > x,
    do: guess(x, low..guess-1)

end
