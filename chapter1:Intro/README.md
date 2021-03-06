Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

## Elixir

Is:
* functional
* with immutable state
* and actor-based concurrency
* wrapped up "in a tidy, modern syntax"
* offering "industrial strength, high-performance" via Erlang VM.

### Programming Should Be About Transforming Data

In the object-orientated world, you think of classes and instances which are all about...

> ... data-hiding. But that's not the real world. In the real world, we don't want to model abstract hierarchies (because in reality there aren't that many true hierarchies). We want to get things done, not maintain state. I don't want to hide data. I want to transform it. - Dave Thomas

### Combine Transformations with Pipelines

* flexible
* reliable
* parallelizable

```Elixir
defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end
```

### Functions are Data Transformers

> If we want, we can make these functions run in parallel—Elixir has a simple but powerful mechanism for passing messages between them. And these are not your father’s boring old processes or threads—we’re talking about the potential to run millions of them on a single machine and have hundreds of these machines interoperating.

> But this power comes at a price. You’re going to have to unlearn a whole lot of what you know about programming. Many of your instincts will be wrong. And this will be frustrating, because you’re going to feel like a total n00b. Personally, I feel that’s part of the fun.

> -- Dave Thomas

### Chapter Notes

> Think Different(ly)

### My Notes
A year ago, I was all-in on object-orientated programming and also saw any additional complexity in (web) app design and development as an unnecessary risk. This kept me from diving into other languages (such as Elixir) which kept me from growing as a developer.

Over the past year I have been putting a lot of thought into "thinking". Not just thinking related to programming, but thinking about all areas of personal and professional development.

I realize I'm not an early member of the Elixir community. The first _Programming Elixir_ book came out more than three years ago and was being written four years ago. Yet Elixir still feels brand new to me. So, I'm looking forward to the opportunity with Elixir to Think Different(ly). -- Scott
