Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

## Elixir Basics

### Value Types

> The value types in Elixir represent numbers, names, ranges, and regular expressions.

```Elixir
# Atoms
# An atom’s name is its value.
# Like Ruby's symbols.
iex(11)> me = :scott
:scott
iex(12)> she = :karen
:karen
iex(13)> he = :scott
:scott
iex(14)> me == he
true
iex(15)> he == she
false
```

```Elixir
# Ranges
iex(17)> 1..2
1..2
```

### System Types

> These types reflect resources in the underlying Erlang VM.

### Collection Types

```Elixir
# Tuples
iex(19)> {1, 2}
{1, 2}
iex(20)> { :ok, 200, "next" }
{:ok, 200, "next"}
iex(21)> { status, count, action } = {:ok, 42, "next"}
{:ok, 42, "next"}
iex(22)> status
:ok
iex(23)> count
42
iex(24)> action
"next"
```

```Elixir
# Lists
iex(25)> [ 1, 2, 3 ] ++ [4, 5, 6]
[1, 2, 3, 4, 5, 6]
iex(26)> [ 1, 2, 3 ] -- [2, 4]
[1, 3]
iex(27)> 1 in [1, 2, 3, 4]
true
```

```Elixir
# Maps
iex(1)> languages = %{ "rb" => "ruby", "exs" => "Elixir"}
%{"exs" => "Elixir", "rb" => "ruby"}
iex(2)> colors = %{ roses: "red", violets: "blue" }
%{roses: "red", violets: "blue"}
iex(3)> languages["rb"]
"ruby"
iex(5)> colors[:roses]
"red"
iex(6)> colors.roses
"red"
```

```Elixir
# Binaries
# Unlikely to use directly
iex(1)> bin = << 1, 2 >>
<<1, 2>>
iex(2)> byte_size bin
2
```

```Elixir
# Dates and Times
iex(1)> d1 = Date.new(1992, 08, 01)
{:ok, ~D[1992-08-01]}
iex(2)> {:ok, d2} = Date.new(1992, 08, 01)
{:ok, ~D[1992-08-01]}

iex(1)> d1 = Date.new(1992, 08, 01)
{:ok, ~D[1992-08-01]}
iex(2)> {:ok, d2} = Date.new(1992, 08, 01)
{:ok, ~D[1992-08-01]}
iex(3)> d1 == d2
false
iex(4)>  d1 = Date.new(1992, 08, 01)
{:ok, ~D[1992-08-01]}
iex(5)>  d2 = Date.new(1992, 08, 01)
{:ok, ~D[1992-08-01]}
iex(6)> d1 == d2
true
iex(7)> t1 = Time.new(12, 34, 56)
{:ok, ~T[12:34:56]}
iex(8)> t2 = Time.new(12, 34, 56)
{:ok, ~T[12:34:56]}
iex(9)> t1 == t2
true
iex(10)> inspect t2, structs: false
"{:ok, %{__struct__: Time, hour: 12, microsecond: {0, 0}, minute: 34, second: 56}}"
```
