## Maps, Keyword Lists, Sets, and Structs

### Chapter Notes

In this chapter, pattern matching continues its prominence. Pattern matching is used for:
* searching maps
* searching a collection of maps
* handling results of Map methods such as `pop`
* matching functions to transform data in Structs

Handling of maps and the Access module remind of React's immutability helpers. In fact an immutable approach with React/Redux would seem to fit well with Elixir. But for a counter point take a look at [How We Replaced React with Phoenix](https://robots.thoughtbot.com/how-we-replaced-react-with-phoenix).

As a developer, I under-utilize Sets. Because you can do set-type logic with Arrays, I find myself using Arrays forgetting that Sets would be more performant in some scenarios. This chapter's touch on Sets was a good reminder to use them more often.

This chapter had no exercises. So I just made up some of my own as I went along. This chapter briefly used `for` and comprehensions before they are explained (in chapter 10).

An aside: [msaraiva's](https://github.com/msaraiva) [Atom package for Elixir](https://github.com/msaraiva/atom-elixir) is really good.

### When to use which:

* pattern-match? map
* duplicate keys? Keyword
* ordered? Keyword
* else map (and I'd add: ideally specifically a Struct)

### Keyword Lists

* use to hold default options in module attributes
* use to send options to a function, e.g:

```Elixir
defmodule Canvas do

  # module attribute, think of this like you
  # might constants in other languages
  @defaults [ fg: "blue", bg: "white", font: "Cursive"]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Text:    #{inspect(text)}"
    IO.puts "Fg:      #{options[:fg]}"
    IO.puts "Bg:      #{options[:bg]}"
    IO.puts "Font:    #{options[:font]}"
    IO.puts "Pattern: #{options[:pattern]}"
  end
end
```

### Maps

* performant!
* well supported withy a comprehensive API, e.g.:

```Elixir
# Create with %
iex(8)> map = %{ author: 'Scott', editor: 'Atom', language: 'Elixir' }
%{author: 'Scott', editor: 'Atom', language: 'Elixir'}
# Access with atom...
iex(9)> map[:author]
'Scott'
# or dot notation.
iex(10)> map.author
'Scott'
# Put - Recall immutability so assignment required to do anything with the new Map.
iex(13)> map2 = Map.put map, :from_language, "Ruby"
%{author: 'Scott', editor: 'Atom', from_language: "Ruby", language: 'Elixir'}
iex(14)> Map.keys map2
[:author, :editor, :from_language, :language]
iex(15)> Map.has_key? map, :author
true
# Pop - Assignment via pattern matching.
iex(16)> { value, map3 } = Map.pop map2, :from_language
{"Ruby", %{author: 'Scott', editor: 'Atom', language: 'Elixir'}}
iex(17)> value
"Ruby"
iex(18)> Map.equal? map, map3
true
iex(19)> map3
%{author: 'Scott', editor: 'Atom', language: 'Elixir'}
iex(20)> map
%{author: 'Scott', editor: 'Atom', language: 'Elixir'}
```

### Pattern Matching to Search and Update Maps

* Searching maps by keys and value.
* Pattern matching destructures and assigns matches.

```Elixir
iex(1)> animal = %{name: "Boy", age: 10}
%{age: 10, name: "Boy"}
iex(2)> %{ name: a_name } = animal
%{age: 10, name: "Boy"}
iex(3)> a_name
"Boy"
iex(4)> %{ name: a_name, age: _ } = animal
%{age: 10, name: "Boy"}
iex(5)> a_name
"Boy"
iex(6)> %{ name: a_name, age: an_age } = animal
%{age: 10, name: "Boy"}
iex(7)> an_age
10
iex(8)> %{ name: "Boy" } = animal
%{age: 10, name: "Boy"}
```

We can use pattern matching across a collection.

```Elixir
iex(1)> people = [
...(1)> %{ name: "Scott", height: 73 },
...(1)> %{ name: "Karen", height: 57 },
...(1)> %{ name: "Jon",   height: 74 } ]
[%{height: 73, name: "Scott"}, %{height: 57, name: "Karen"},
 %{height: 74, name: "Jon"}]
iex(2)> IO.inspect(for person = %{ height: height } <- people, height > 70, do: person)
[%{height: 73, name: "Scott"}, %{height: 74, name: "Jon"}]
```

And can match variable keys.

```Elixir
iex(3)> data = %{ name: "Dave", state: "TX", likes: "Elixir" }
%{likes: "Elixir", name: "Dave", state: "TX"}
# Iterate through keys :name and :likes
# Perform match of data with each key.
# The variable value gets assigned on the match.
iex(4)> for key <- [ :name, :likes ] do
...(4)>   %{ ^key => value } = data
...(4)>   value
...(4)> end
["Dave", "Elixir"]
```

### Structs

* Super-powered maps.
* Fixed set of keys.
* Support for default values.
* Written as a module,
* which can contain functions for behavior
* (does this make them class functions?)

Structs give your maps some form and *structure*.

```Elixir
iex(7)> product1 = %Product{name: "Fireworks", instock: true, explosive: true}
%Product{explosive: true, instock: true, name: "Fireworks"}
iex(8)> Product.shippable(product1)
false
iex(9)> Product.print_label(product1)
CAUTION: EXPLOSIVE
:ok

iex(10)> product2 = %Product{name: "Candy Bar", instock: true, explosive: false}
%Product{explosive: false, instock: true, name: "Candy Bar"}
iex(11)> Product.shippable(product2)                                            
true
iex(12)> Product.print_label(product2)                                          
Contains: Candy Bar
:ok

iex(13)> product3 = %Product{name: "Cookies", instock: false}                 
%Product{explosive: false, instock: false, name: "Cookies"}
iex(14)> product3.shippable
** (KeyError) key :shippable not found in: %Product{explosive: false, instock: false, name: "Cookies"}    
# ^^^^^^ Look at me trying to be OO-like out of habit. The mental switch is not a smooth one....
# But on the other hand, this does read like a class method at any rate.
iex(14)> Product.shippable(product3)
false
```

### Sets

Examples:

```Elixir
iex(9)> set1 = 1..10 |> Enum.into(MapSet.new)
#MapSet<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]>
iex(10)> set2 = 3..8 |> Enum.into(MapSet.new)
#MapSet<[3, 4, 5, 6, 7, 8]>
iex(11)> MapSet.member? set1, 3
true
iex(12)> MapSet.member? set2, 3
true
iex(13)> MapSet.member? set2, 10
false
iex(14)> MapSet.difference set1, set2
#MapSet<[1, 2, 9, 10]>
iex(15)> MapSet.intersection set1, set2
#MapSet<[3, 4, 5, 6, 7, 8]>
iex(18)> MapSet.difference set2, set1  
#MapSet<[]>
```

### Conclusion!

> You can write something akin to object-oriented code using structs (or maps) and modules.
This is a bad idea—not because objects are intrinsically bad, but because you’ll be mixing paradigms and diluting the benefits a functional approach gives you.

> Stay pure, young coder. Stay pure.
