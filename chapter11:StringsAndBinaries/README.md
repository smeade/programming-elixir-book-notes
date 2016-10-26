## Strings and Binaries

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Chapter Notes

Continuing down the road of "Part I - Conventional Programming", this chapter covers strings, character lists and binaries.

### Strings vs. character lists

A non-conventional thing about Elixir strings is that double-quoted strings are actual "strings", while single-quoted list of characters are character lists. This is important, especially when sending params to functions that expect one or the other. Both string and character list forms support interpolation, heredocs and sigils.

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

* a sequence of bits
* `<< bit1, bit2, ... >>`
* strings are binaries
* so need to use `String` module instead of lists

```Elixir
iex(1)> dqs = "∂x/∂y"
"∂x/∂y"
iex(2)> String.length dqs
5
iex(3)> byte_size dqs
9
iex(4)> String.at(dqs, 0)
"∂"
iex(5)> String.split(dqs, "/")
["∂x", "∂y"]
```

#### Binaries and Pattern Matching

* can match on type
* `binary, bits, bitstring, bytes, float, integer, utf8, utf16, and utf32`

Processing binaries:
* use `<< head::utf8, tail::binary >>` as params in recursive function
* look for empty binary `<<>>` as terminating pattern match

#### Exercises!

See [mystring.exs](mystring.exs).