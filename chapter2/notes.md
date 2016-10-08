# Pattern Matching

## Assignment

* `=` is as an assertion, not an assignment.
* Elixir looks for ways to make LHV the same as the RHV.

```Elixir
iex(1)> list = [1, 2, [ 3, 4, 5]]
[1, 2, [3, 4, 5]]
iex(2)> [a, b, c] = list
[1, 2, [3, 4, 5]]
iex(3)> a
1
iex(4)> b
2
iex(5)> c
[3, 4, 5]
```

### _ (Underscore)

* Allow any value...

```Elixir
iex(6)> [a, _, c] = [1, 2, 3]
[1, 2, 3]
iex(7)> a

iex(13)> [a, 2, c] = [1, 2, 3]
[1, 2, 3]
iex(14)> [a, 3, c] = [1, 2, 3]
** (MatchError) no match of right hand side value: [1, 2, 3]

iex(14)> [a, _2, c] = [1, 2, 3]
[1, 2, 3]
iex(15)> [a, _3, c] = [1, 2, 3]
[1, 2, 3]
```

### ^ (Pin)

```Elixir
iex(17)> a = 1
1
iex(18)> [^a, 2, 3] = [1, 2, 3 ]
[1, 2, 3]
iex(19)> a
1
iex(20)> [^a, 2, 3] = [4, 2, 3 ]
** (MatchError) no match of right hand side value: [4, 2, 3]
```

## Looking differently at the Equals Sign

> you had to unlearn the algebraic meaning of = when you first came across assignment in imperative programming languages. Now’s the time to un-unlearn it.
That’s why I talk about pattern matching as the first chapter in this part of the book. It is a core part of Elixir—we’ll also use it in conditions, function calls, and function invocation.

>  I wanted to get you thinking differently about programming languages and to show you that some of your existing assumptions won’t work in Elixir.

I like Dave's writing style. I like how he hasn't written a technical reference book. It's a journey to reconsider what we OOP programmers thought we knew about programming. One can find most technical details of a language easily online. What I enjoy about books like this is the chance to follow the thought-journey of a thought-leader.
