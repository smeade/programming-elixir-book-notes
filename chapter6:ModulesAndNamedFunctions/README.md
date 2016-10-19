## Modules and Named Functions

My notes: Working through the exercises in the book is pretty straightforward because the prompts are written out in a way that make them easy to turn into code.

The challenge when writing my own functions will be to frame the problem in a functional manner. Distilling the purpose of a function down to it's "functional" description can be a challenge. Elixir helps by lending itself to small functions that do one thing.

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

See `times.exs`.

### Function Calls and Pattern Matching

Multiple definitions of the same function allow us to start by implementing the simplest case with a known return value. Then use that case recursively in other definitions.

See `factorial1.exs`.

#### Exercises

See `recursion.exs`.

