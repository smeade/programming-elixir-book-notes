Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

## Immutability

* Elixir enforces immutability...
* ...it is a functional language after all

### Chapter Notes

The difference between assignment and binding is nuanced, especially I suspect for new programmers. As Dave points out, immutability in Elixir does not mean that you cannot rebind a variable. Dave does not go into much explanation here. I suspect in order to keep things moving.

Let me see if I can explain to myself in another way. Say you have a bumper sticker on your car. Say the bumper on your car is your variable containing the sticker. (bumper = sticker in psuedo-code (?)) The sticker says "Ruby!". In a mutable-allowed language, you could change the bumper sticker to read "Elixir!". Your bumper would still contain the same sticker (in psuedo-code, bumper would still reference the same sticker), but the sticker now says "Elixir!".

Instead of changing the sticker, Elixir create another sticker, this one saying 'Elixir!' and binds that new one to your bumper. Your bumper's sticker now says "Elixir!" and the old sticker that says 'Ruby!' also still exists until it is garbage-collected (or recycled in your garage recycling bin to continue the analogy).

Interestingly, Erlang does not even allow re-binding. See: José Valim's [Comparing Elixir and Erlang variables](http://blog.plataformatec.com.br/2016/01/comparing-elixir-and-erlang-variables/) for more discussion on this.


###"Immutable data is known data" - avoids problems

> GOTO was evil because we asked, "how did I get to this point of execution?" Mutability leaves us with, "how did I get to this state?" - Jessica Kerr (@jessitron) https://twitter.com/jessitron/status/333228687208112128

###Immutable data structures allow for performant programs

###Coding
* Functions that transform data return a new copy of the data.
* Functions always transform and never change the data in place.

```Elixir
iex(1)> name = "favstar"
"favstar"
iex(2)> name
"favstar"
iex(3)> name = "capme"
"capme"
iex(4)> cap_name = String.capitalize name
"Capme"
iex(5)> cap_name
"Capme"
iex(6)> name
"capme"
```

>  In Elixir, all values are immutable. The most complex nested list, the database record—these things behave just like the simplest integer. Their values are all immutable.

> In Elixir, once a variable references a list such as [1,2,3], you know it will always reference those same values (until you rebind the variable). And this makes concurrency a lot less frightening.

> That’s enough theory. It’s time to start learning the language.

> -- Dave Thomas

I agree - let's go!
