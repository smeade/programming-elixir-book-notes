defmodule Canvas do

  # module attributes, think of these like you
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
