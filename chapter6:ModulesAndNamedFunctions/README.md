## Modules and Named Functions

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir/programming-elixir) by [Dave Thomas](https://twitter.com/pragdave).

### Chapter Notes

So far, solving the exercises in the book is pretty straightforward because the prompts are written out in a way that make them easy to turn into code. The challenge when writing one's own functions will be to frame the problem in a functional manner. Distilling the purpose of a function down to its "functional" description can be a challenge. Elixir helps by lending itself to small functions that do one thing.

*Error messages* in Elixir are great. The error messages don't just say 'fail', but also give a recommendation on how you might resolve the unexpected error.

Here's a lengthy example from this chapter:

```
warning: definitions with multiple clauses and default values require a
function head. Instead of:
    def foo(:first_clause, b \\ :default) do ... end
    def foo(:second_clause, b) do ... end
one should write:
    def foo(a, b \\ :default)
    def foo(:first_clause, b) do ... end
    def foo(:second_clause, b) do ... end
```

### Named functions

Named functions live inside modules.

```Elixir
# named_function/1
defmodule ModuleName do
  def named_function(n) do
    # do something / return something
  end
end
```

```Elixir
iex(1)> c "times.exs"
[Times]
iex(2)> Times.double(4)
8
```

#### Arity

The name and number of parameters uniquely identify a function. `function1(x)` and `function1(x, y)` are two completely different and independent functions. Refer to them as function1/1 and function2/2.

#### Blocks

Use `do:` for single line functions and `do..end` for multi-line functions.

#### Exercises

> Extend the Times module with a triple function that multiplies its parameter by three. Add a quadruple function. (Maybe it could call the double function....)

See [times.exs](times.exs).

### Function Calls and Pattern Matching

Multiple definitions of the same function allow us to start by implementing the simplest case with a known return value. Then use that case recursively in other definitions.

See [factorial1.exs](factorial1.exs).

#### Exercises

See [recursion.exs](recursion.exs).

### Guard Classes

* Guard classes are used to decide which function to use based on a `when` clause.
* Pattern matching first, then guard clause.

```Elixir
defmodule Guard do
  def what_is(x) when is_atom(x), do: IO.puts "#{x} is an atom"
  def what_is(x) when is_list(x), do: IO.puts "#{inspect(x)} is a list"
  def what_is(x) when is_number(x), do: IO.puts "#{x} is a number"
end
```

```Elixir
iex(1)> Guard.what_is(:ok)
ok is an atom
:ok
```

### Default Parameters

* syntax: `param \\ value`

```Elixir
defmodule Example do
def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
end end
```

```Elixir
iex(1)> Defaults.func("a", "b")
["a", 2, 3, "b"]
iex(2)> Defaults.func("a", "b", "c")
["a", "b", 3, "c"]
iex(3)> Defaults.func("a", "b", "c", "d")
["a", "b", "c", "d"]
```

If the number of provided arguments matches the number of required params, then the provided arguments are assigned, left to right, to the required params. See iex(1) above.

If the number of provided arguments is greater than the number of required params, then the number of optional params to be populated is determined and the params are assigned left to right using only the number of optional params needed. See iex(2) and iex(3) above.

This makes sense because it's all about pattern matching. The assignment process looks to match the provided arguments with the function's parameters.

An aside: Note that Ruby does the same.

```Ruby
> def func(p1, p2=2, p3=3, p4)
>   puts [p1, p2, p3, p4].inspect()
> end
 => nil
> func("a", "b")
["a", 2, 3, "b"]
 => nil
> func("a", "b", "c")
["a", "b", 3, "c"]
> func("a", "b", "c", "d")
["a", "b", "c", "d"]
```

If the number of provided arguments is less than the number of required arguments or greater than the number of required plus optional arguments, then there is no match and you get an `UndefinedFunctionError` error.

```
** (UndefinedFunctionError) function Defaults.func/1 is undefined or private.
** (UndefinedFunctionError) function Defaults.func/5 is undefined or private.
```

Ruby:
```
2.0.0-p353 :043 > func("a")
ArgumentError: wrong number of arguments (1 for 2..4)
```

#### Exercise!

Wrote a guesser function that finds a number by guessing halfway between the low and high of a range. Continues to adjust the number and the range until the guess matches the number.

My solution is [chop.exs](chop.exs).

### The Pipe Operator: |>

Cool!

Instead of:

```Ruby
people = DB.find_customers
orders = Orders.for_customers(people)
tax    = sales_tax(orders, 2016)
filing = prepare_filing(tax)
```

```Elixir
filing = DB.find_customers
           |> Orders.for_customers
           |> sales_tax(2016)
           |> prepare_filing
```

### Modules

* provide namespaces, like so:

```Elixir
defmodule Mod do
  def func1 do
    IO.puts "in func1"
  end
  def func2 do
    func1
    IO.puts "in func2"
  end
end
Mod.func1
Mod.func2
```

#### The import directive

* brings a module’s functions and/or macros into the current scope
* so that you don't need to repeat the module name over and over.

```Elixir
import List, only: [ flatten: 1, duplicate: 2 ]
```

#### The alias directive

* make for shorter names

```Elixir
alias My.Other.Module.Parser, as: Parser
...
Parser.parse()
```

### Module Attributes

* `@name value`
* top-level module-level only, functions do not have attributes
* think of them as constants used for configuration and metadata

see: [attributes.exs](attributes.exs).
