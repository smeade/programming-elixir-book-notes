## Lists and Recursion

### Chapter Notes

Is recursion as huge a deal in Elixir as this chapter makes it seem? I can see how pattern matching makes recursion an attractive tool, but I can also see other options. Anxious to dive into some real-life Elixir code to see what happens in practice.

I started to think of the use of recursion combined with pattern matching as a `while` loop.

```Elixir
  def span(from, to) when from <= to do: [ from | span(from + 1, to) ]
```

Is like saying `while from <= to...`. Just be sure to have another function that captures the other cases `when from > to`. Or even better, treat the recursive part as the general case and remove the `when` from it.

```Elixir
# stop recursion when from > to
def span(from, to) when from > to, do: []
# create list with from at head and tail made of
# recursive calls to span
def span(from, to), do: [ from | span(from + 1, to) ]
```

### My Pulse

I'm so ready to get through Part I - Conventional Programming part of the book and onto the Concurrent Programming chapters. But I know that I learn best by building up a foundation and so do want to have a solid understanding of these fundamentals.

I'm also anxious to read [Programming Pheonix](https://pragprog.com/book/phoenix/programming-phoenix) but, again, want to have at least a basic understanding and comfort with Elixir first.

### Heads and Tails

* Recursive because a list's tail is a list.
* []
* [ y | [] ]
* [ x | [ y | [] ] ]

* Let's us do pattern matching like so:

```Elixir
iex(1)> [ head | tail ] = [ 1, 2, 3 ]
[1, 2, 3]
iex(2)> head
1
iex(3)> tail
[2, 3]
```

### Example of Lists and Recursion

> lists and recursive functions go together like fish and chips

:)

See [mylist.exs](mylist.exs) for en example of processing lists with recursion. Pairs of functions in this module match either an empty list or a non-empty list. Matches to an empty list return simply a new empty list. Matches to a non-empty list return a new list with the head value transformed (squared, added, etc) and the tail a recursive call to the function.

```Elixir
iex(3)> MyList.add_1 [1000,2000]
[1001, 2001]    
iex(4)> MyList.square [1,2,3,4]
[1, 4, 9, 16]
```

### Creating a Map function

* Generalizing the pattern into a function that takes a function.
* Functions are built-in types that can be passed as arguments.

```Elixir
def map([], _func),             do: []
def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]
```

```Elixir
iex(6)> MyList.map [1, 2, 3, 4], fn n -> n * n end
[1, 4, 9, 16]
iex(7)> MyList.map [1, 2, 3, 4], fn n -> n + n end
[2, 4, 6, 8]
```

### Keeping Track of Values During Recursion

* No global namespace so
* pass the 'current' value into the function with each call.
* Hide the initial value by making a public interface that sets it.

```Elixir
def sum(list), do: _sum(list, 0)
defp _sum([], total), do: total
defp _sum([ head | tail ], total), do: _sum(tail, head+total)
```

#### Exercise

* Write the sum function without an accumulator.
* My solution uses recursion just like the other functions in this chapter above.

```Elixir
def sum2([]),               do: 0
def sum2([ head | tail ]),  do: head + sum2(tail)

iex(2)> MyList.sum2([1,2,3])
6
iex(3)> MyList.sum2([1,2,3,4,5,6])
21
```

### Reduce

Take a collection and _reduce_ it to a value. Write a function something like `reduce(collection, initial_value, fun)`.

See [mylist.exs](mylist.exs) `reduce` function. Recursively calls the provided function with tail as the collection and head and value as the value.

#### Exercises

See [mylist.exs](mylist.exs) for my solutions to the exercises.

### Complex Lists

See [mylist.exs](mylist.exs) for my solutions to the exercises.

### List module

Elixir's list module includes concatenation, flattening, folding, updating and searching tuples.

```Elixir
iex(1)> [1, 2, 3] ++ [4, 5, 6]
[1, 2, 3, 4, 5, 6]

iex(2)> List.flatten( [[1,2]], [1,3])
[1, 2, 1, 3]

iex(3)> List.replace_at([1,2,3], 2, "three")
[1, 2, "three"]

iex(4)> kw = [{:name, "Dave"}, {:likes, "Programming"}, {:where, "Dallas", "TX"}]
[{:name, "Dave"}, {:likes, "Programming"}, {:where, "Dallas", "TX"}]
iex(5)> List.keyfind(kw, "Dallas", 1)
{:where, "Dallas", "TX"}
iex(6)> List.keyfind(kw, "TX", 1)    
nil
iex(7)> List.keyfind(kw, "TX", 2)
{:where, "Dallas", "TX"}
```
