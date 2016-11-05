## Tooling

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Testing

I love that Elixir, like Ruby, treats testing as a first class citizen and is part of the way that Elixir apps get built.

#### Doc Test

Runs iex sessions in comments (`@doc` strings) and checks that the output matches that specified in the comment.

```Elixir
@doc """
Generate the line that goes below the column headings. It is a string of hyphens, with + signs where the vertical bar between the columns goes.
## Example
      iex> widths = [5,6,9]
      iex> Issues.TableFormatter.separator(widths)
      "------+--------+----------"
"""
def separator(column_widths) do
  map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
end
```

Add `doctest` to test files:

```Elixir
defmodule DocTest do
  use ExUnit.Case
  doctest Issues.TableFormatter
end
```

Then run like so:
```Elixir
$ mix test test/doc_test.exs
```

#### Structuring Tests

