## Anonymous Functions

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

