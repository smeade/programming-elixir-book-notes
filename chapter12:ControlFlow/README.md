## Control Flow

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Chapter Notes

I didn't spend much time in this chapter because 1) it's familiar territory and 2) the Elixir way is to not use much control flow syntax.

A reminder:
* Imperative programming focusses on the "how", the steps to implementation.
* Declarative programming style focusses on the "what", the code describes the problem itself. Declarative is is the Elixir way.

### Control Flow

> Elixir does have a small set of control-flow constructs. The reason I’ve waited so long to introduce them is that I want you to try not to use them much. You definitely will, and should, drop the occasional if or case into your code. But before you do, consider more functional alternatives. -- Dave Thomas

### if and unless

```Elixir
if 1 == 1 do
  "true!"
else
  "false :("
end
```

```Elixir
unless 1 == 1, do: "error", else: "OK"
```

### cond

```Elixir
#---
# Excerpted from "Programming Elixir 1.3",
# published by The Pragmatic Bookshelf.
defmodule FizzBuzz do

  def upto(n) when n > 0, do: _upto(1, n, [])

  defp _upto(_current, 0, result),  do: Enum.reverse result  

  defp _upto(current, left, result) do
    next_answer =      
      cond do
        rem(current, 3) == 0 and rem(current, 5) == 0 ->
          "FizzBuzz"
        rem(current, 3) == 0 ->
          "Fizz"
        rem(current, 5) == 0 ->
          "Buzz"
        true ->
          current
      end
    _upto(current+1, left-1, [ next_answer | result ])
  end
end
```

The cool thing is we wrote a FizzBuzz using no control flow logic in [Chapter 5, Anonymous Functions(../chapter5:AnonymousFunctions/README.md). Here is a modularized version.

```Elixir
#---
# Excerpted from "Programming Elixir 1.3",
# published by The Pragmatic Bookshelf.
defmodule FizzBuzz do
  def upto(n) when n > 0, do:  1..n |> Enum.map(&fizzbuzz/1)

  defp fizzbuzz(n), do: _fizzword(n, rem(n, 3), rem(n, 5))

  defp _fizzword(_n, 0, 0), do: "FizzBuzz"
  defp _fizzword(_n, 0, _), do: "Fizz"
  defp _fizzword(_n, _, 0), do: "Buzz"
  defp _fizzword( n, _, _), do: n
end
```

### case

* can use pattern matches
* can use guard clauses

```Elixir
#---
# Excerpted from "Programming Elixir 1.3",
# published by The Pragmatic Bookshelf.
defmodule Bouncer do
  dave = %{name: "Dave", age: 27}

  case dave do
    person = %{age: age} when is_number(age) and age >= 21 ->
      IO.puts "You are cleared to enter the Foo Bar, #{person.name}"
    _ ->
      IO.puts "Sorry, no admission"
  end
end
```
