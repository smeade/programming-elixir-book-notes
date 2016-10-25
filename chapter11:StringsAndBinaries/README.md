## Strings and Binaries

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Chapter Notes

#### Interpolation:

```Elixir
iex(3)> name = "Dave"
"Dave"
iex(4)> "Hello, #{name}"
"Hello, Dave"
iex(5)> name = 'Don'
'Don'
iex(6)> "Hello, #{name}"
"Hello, Don"
```

#### Heredocs:

* ''' or """
* and indent
* good for docs

```Elixir
IO.puts "start"
IO.write """
  my
  string
  """
IO.puts "end"
```

#### Sigils:

> Like Ruby, Elixir has an alternative syntax for some literals.
> starts with a tilde, followed by an upper- or lowercase letter, some delimited content...

```Elixir
iex(12)> ~W[the way to win is to play a lot]a
[:the, :way, :to, :win, :is, :to, :play, :a, :lot]
iex(13)> ~w[the way to win is to play a lot]c
['the', 'way', 'to', 'win', 'is', 'to', 'play', 'a', 'lot']
iex(14)> ~w[the way to win is to play a lot]s
["the", "way", "to", "win", "is", "to", "play", "a", "lot"]
```

#### Character Codes:

* Single quoted, e.g. `charcode`.
* Is a list of integer character codes.

```Elixir
iex(15)> 'pole' ++ 'vault'
'polevault'
iex(16)> 'pole' -- 'vault'
'poe'
```

#### Exercises!

See [mylist.exs](mylist.exs) for my solutions.

```Elixir
iex(13)> MyString.anagram?('mom', 'omm')
true
iex(14)> MyString.anagram?('mom', 'ohm')
false
```

### Binaries

