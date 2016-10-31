## Organizing a Project

Notes and exercises while reading through [Programming Elixir](https://pragprog.com/book/elixir13/programming-elixir-1-3) by [Dave Thomas](https://twitter.com/pragdave).

### Chapter Notes

> Let’s stop hacking and get serious.

Yay!

* mix - Elixir build tool
* external dependencies
* ExUnit - testing framework
* libraries, etc.

Excited to make something now! This chapter gives a small taste of OTP as well.

### The Project: Fetch Issues from Github

* command line program
* github username, project name, count ---> program ---> issues in table format
* access as HTTP client
* response in JSON

### Use Mix to Create Our New Project

Mix:

* has tasks (like rake)
* `mix new` creates project skeleton

```
mix new issues
```

#### Project Tree Conventions

Parser:
* module _Project.CLI_ (e.g. Issues.CLI) is the command line parser
* `def run` in that module is the main entry point

Namespace:
* `/lib/_projectname_` (e.g. /lib/issues) contains `cli.ex`
* `/lib/issues/cli.ex`
* '/lib/issues.ex'

### Transformation: Parse the Command Line

OptionParser:
* Use Elixir's provided OptionParser methods
* Includes support for switches (such as --help -h)

### Write Tests

Thumbs up!

See `issues\test\issues_test.exs` for skeleton of an ExUnit test.

```
work:issues smeade$ mix test
Compiling 1 file (.ex)
....

Finished in 0.03 seconds
4 tests, 0 failures
```

### Run from command line

Pass `mix run` an Elixir expression.

```
$ mix run -e 'Issues.CLI.run(["-h"])'
usage: issues <user> <project> [ count | 4 ]
```

### Use libraries

Look for libraries in:
* `http://elixir-lang.org/docs.html`
* `http://erlang.org/doc/`
* External dependencies

#### hex
* package manager (like rubygems, npm, etc.)
* `https://hex.pm/`
* Add to `mix.exs`

#### `def application`

> OTP is the framework that manages suites of running applications. The application function configures the contents of these suites.

Instead of calling _Library_.start, add the library to the suite of applications that is being managed by OTP. You do that by adding it to `mix.exs` `application` function.

```Elixir
def application do
[ applications: [ :logger, :httpoison ] ]
end
```

