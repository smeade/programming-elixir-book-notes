defmodule Product do
  defstruct name: "", instock: false, explosive: false

  def shippable(product = %Product{}) do
    product.instock && !product.explosive
  end

  def print_label(%Product{explosive: true}) do
    IO.puts "CAUTION: EXPLOSIVE"
  end
  def print_label(%Product{name: name}) when name != "" do
    IO.puts "Contains: #{name}"
  end
  def print_label(%Product{}) do
    IO.puts "Unknown contents"
  end
end
