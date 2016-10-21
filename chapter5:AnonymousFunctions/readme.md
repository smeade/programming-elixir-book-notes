## Anonymous Functions

### Chapter Notes

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

As much as learning new syntax, Elixir's functional and declarative programming stye is an enjoyable refactoring of my mental modal of software. I know I'm late to the bandwagon and that functional, declarative programming is not a silver bullet. I also know that beautiful and fine OO and imperative code is written every day - but allow me this ray of new hope and optimism!

### Functions

* are a basic type
* can be passed to other functions
* `fn parameter-list -> body end`

```Elixir
iex(1)> sum = fn (a, b) -> a + b end
#Function<12.52032458/2 in :erl_eval.expr/5>
iex(2)> sum.(200, 201)
401
```

```Elixir
iex(3)> f1 = fn a, b -> a * b end
#Function<12.52032458/2 in :erl_eval.expr/5>
iex(4)> f1.(5,6)
30
```

### Exercise
```Elixir
iex(5)> list_concat = fn list1, list2 -> list1 ++ list2 end
#Function<12.52032458/2 in :erl_eval.expr/5>
iex(6)> list_concat.([:a, :b], [:c, :d])
[:a, :b, :c, :d]
```

```Elixir
iex(7)> sum = fn a,b,c -> a+b+c end
#Function<18.52032458/3 in :erl_eval.expr/5>
iex(8)> sum.(1,2,3)
6
```

```Elixir
iex(9)> pair_tuple_to_list = fn {x,y} -> [x, y] end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(10)> pair_tuple_to_list.( { 1234, 5678 } )
[1234, 5678]
```

### One Function, Multiple Bodies

> A single function definition lets you define different implementations, depending on the type and contents of the arguments passed.

```Elixir
iex(15)> fizzbuzz = fn    
...(15)>   0, 0, _ -> "FizzBuzz"
...(15)>   0, _, _ -> "Fizz"
...(15)>   _, 0, _ -> "Buzz"
...(15)>   _, _, z -> z
...(15)> end
#Function<18.52032458/3 in :erl_eval.expr/5>
iex(16)> fizzbuzz.(0, "any", "thing")
"Fizz"
iex(17)> fizzbuzz.(0, 0, "thing")    
"FizzBuzz"
iex(18)> fizzbuzz.(1, 2, 3)      
3
```

```Elixir
iex(19)> fb = fn n -> fizzbuzz.(rem(n,3), rem(n,5), n) end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(20)> fb.(10)
"Buzz"
iex(21)> fb.(11)
11
iex(22)> fb.(12)
"Fizz"
iex(23)> fb.(13)
13
iex(24)> fb.(14)
14
iex(25)> fb.(15)
"FizzBuzz"
iex(26)> fb.(16)
16
```

### Functions Returning Functions

```Elixir
iex(1)> fun1 = fn -> (fn -> "Hey!" end) end
#Function<20.52032458/0 in :erl_eval.expr/5>
iex(2)> fun2 = fun1.()
#Function<20.52032458/0 in :erl_eval.expr/5>
iex(3)> fun2.()
"Hey!"
iex(4)> fun1.().()
"Hey!"
```

#### Closure / Parameterized Functions

> functions in Elixir automatically carry with them the bindings of variables in the scope in which they are defined

> Write a function prefix that takes a string. It should return a new function that takes a second string. When that second function is called, it will return a string containing the first string, a space, and the second string.

```Elixir
# Exercise: Functions-4
iex(1)> prefix = fn string1 -> (fn string2 -> "#{string1} #{string2}" end) end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(2)> mrs = prefix.("Mrs")
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(3)> mrs.("Smith")
"Mrs Smith"
iex(4)> mr = prefix.("Mr")
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(5)> mr.("Jones")
"Mr Jones"
iex(6)> prefix.("Elixir").("Rocks")
"Elixir Rocks"
```

### Passing Functions As Arguments

Because functions are values, they can be passed to other functions.

```Elixir
iex(1)> times3 = fn n -> n * 3 end
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(2)> apply = fn (fun, value) -> fun.(value) end
#Function<12.52032458/2 in :erl_eval.expr/5>
iex(3)> apply.(times3, 6)
18
```

```Elixir
iex(5)> list = [1, 2, 3, 4, 5]
[1, 2, 3, 4, 5]
iex(6)> Enum.map list, fn elem -> elem * 2 end
[2, 4, 6, 8, 10]
iex(7)> Enum.map list, fn elem -> elem * elem end
[1, 4, 9, 16, 25]
```

### & Notation

```Elixir
iex(8)> add_one = &(&1 + 1)
#Function<6.52032458/1 in :erl_eval.expr/5>
iex(9)> add_one.(55)
56
```

> Because [] and {} are operators in Elixir, literal lists and tuples can also be turned into functions.

Exercise: Functions-5: Use the &... notation to rewrite the following.

```Elixir
iex(12)> Enum.map [1,2,3,4], fn x -> x + 2 end
[3, 4, 5, 6]
iex(13)> Enum.map [1,2,3,4], &(&1 + 2)
[3, 4, 5, 6]

Interactive Elixir (1.3.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> Enum.each [1,2,3,4], fn x -> IO.inspect x end
1
2
3
4
:ok    
iex(2)> Enum.each [1,2,3,4], &(IO.inspect &1)
1
2
3
4
:ok
```

### Functions!

Transformation of data is the primary purpose of programming, it's raison d'etre. Functions are what let us do the transforming.

> At the start of the book, we said the basis of programming is transforming data. Functions are the little engines that perform that transformation. They are at the very heart of Elixir.
