## ProcessingCollections - Enum and Stream

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Chapter Notes

This is the closest to a reference chapter so far. The exercises are good.

### Enum

```Elixir
iex(1)> list = Enum.to_list 20..30
[20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
iex(2)> list2 = [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
[20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
iex(3)> list == list2
true
iex(4)> Enum.concat([1,2,3], [4,5,6])
[1, 2, 3, 4, 5, 6]
iex(5)> Enum.map(list, &(&1 * 10))
[200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300]
iex(6)> Enum.at(list, 3)
23
iex(7)> Enum.filter(list, &(&1 > 2))
[20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
iex(8)> Enum.filter(list, &(&1 > 20))
[21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
iex(9)> Enum.sort list
[20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
iex(10)> Enum.max ist
** (CompileError) iex:10: undefined function ist/0

iex(10)> Enum.max list
30
iex(11)> Enum.min list
20
iex(12)> Enum.take(list, 3)
[20, 21, 22]
iex(13)> Enum.all?(list, &(&1 < 25))
false
iex(14)> Enum.any?(list, &(&1 < 25))
true
iex(15)> Enum.reduce(1..100, &(&1+&2))
5050
iex(16)> Enum.reduce(1..2, &(&1+&2))  
3
iex(3)> Enum.reduce([1, 2, 3, 4, 5], [], fn val, acc ->
...(3)> [val, acc]
...(3)> end)
[5, [4, [3, [2, [1, []]]]]]
# If the starting accumulator value is not provided,
# the first item in the collection essentially becomes the accumulator
# and the reduction starts with the second item in the collection.
iex(1)> Enum.reduce([1,2,3,4], fn val, acc ->
...(1)>   [val, acc]
...(1)> end)
[4, [3, [2, 1]]]

iex(4)> Enum.reduce(["this", "is", "a", "sentence", "now"], fn word, acc ->
...(4)>   IO.puts "#{word} #{acc}"
...(4)>   if String.length(word) > String.length(acc) do
...(4)>     word
...(4)>   else
...(4)>     acc
...(4)>   end
...(4)> end)
is this
a this
sentence this
now sentence
"sentence"
```

#### Enum Exercises

> Implement the following Enum functions using no library functions or list ...
see for my solutions

```Elixir
# all? without using library functions
iex(17)> ExList.all?([1,2,3], &(&1 > 4))  
false
iex(18)> ExList.all?([1,2,3], &(&1 > 1))
false
iex(19)> ExList.all?([1,2,3], &(&1 >= 1))
true

# each without using library functions
iex(20)> ExList.each([1,2,3], &(&1 >= 1))
[true, true, true]
iex(21)> ExList.each([1,2,3], &(&1 > 1))
[false, true, true]
iex(22)> ExList.each([1,2,3], &(&1 * 2))
[2, 4, 6]

# filter without using library functions
iex(13)> ExList.filter([1,2,3], &(&1 > 2))
[3]
iex(14)> ExList.filter([1,2,3], &(&1 > 1))
[2, 3]
iex(15)> ExList.filter([1,2,3], &(&1 > 0))
[1, 2, 3]
iex(16)> ExList.filter([1,2,3], &(&1 > 4))
[]

```

### Streams - Lazy Enumerables

* Process elements in a collection as they arrive, so to speak.
* Reduce memory consumption,
* but slower overall.

* Are enumerable
* are composable.

```Elixir
[1,2,3,4] |> Stream.map(&(&1*&1)) |> Stream.map(&(&1+1)) |> Stream.filter(fn x -> rem(x,2) == 1 end) |> Enum.to_list

[5, 17]
```

```Elixir
IO.puts File.stream!("/usr/share/dict/words") |> Enum.max_by(&String.length/1)
```
Great visual on the difference between Enum (greedy) and Stream (lazy).

```Elixir
iex(1)> Enum.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
[2, 3, 4, 5, 6]
iex(2)> Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
[2, 3, 4, 5, 6]
```

### Comprehensions

* used to map and filter collections
* filter conditions: jump to next iteration if false
* example:

```Elixir
iex(3)> for first <- ["Scott", "Jon", "Karen", "Rachel"], last <- ["M", "m", "X"], last != "X", do: "#{first} #{last}"
["Scott M", "Scott m", "Jon M", "Jon m", "Karen M", "Karen m", "Rachel M",
 "Rachel m"]
```

### Exercises!

See: [mylist.exs](mylist.exs)
