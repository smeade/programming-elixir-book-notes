defmodule MyList do
  # Write a function MyList.span(from, to) that returns a list of the numbers
  # from from up to to.
  # stop recursion when from > to
  def span(from, to) when from > to, do: []
  # create list with from at head and tail made of
  # recursive calls to span
  def span(from, to), do: [ from | span(from + 1, to) ]

  # Find prime numbers
  # iex(27)> MyList.prime_list_through(70)
  # [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
  def evenly_divisible(x, y), do: rem(x, y) == 0

  def prime?(2), do: true
  def prime?(n), do: Enum.any?(2..n-1, fn(x) -> evenly_divisible(n, x) end )

  def prime_list_through(n) do
    for x <- span(2, n), prime?(x), do: x
  end

  # Tax rates
  # iex(62)> MyList.orders_report(tax_rates, orders)
  # [[total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.0],
  #  [total_amount: 35.5, id: 124, ship_to: :OK, net_amount: 35.5],
  #  [total_amount: 25.92, id: 125, ship_to: :TX, net_amount: 24.0],
  #  [total_amount: 48.384, id: 126, ship_to: :TX, net_amount: 44.8],
  #  [total_amount: 26.875, id: 127, ship_to: :NC, net_amount: 25.0],
  #  [total_amount: 10.0, id: 128, ship_to: :MA, net_amount: 10.0],
  #  [total_amount: 102.0, id: 129, ship_to: :CA, net_amount: 102.0],
  #  [total_amount: 53.75, id: 130, ship_to: :NC, net_amount: 50.0]]

  orders = [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 130, ship_to: :NC, net_amount:  50.00 ] ]

  tax_rates = [ NC: 0.075, TX: 0.08 ]

  def orders_report(tax_rates, orders) do
    for order <- orders, do: order_with_tax(tax_rates, order)
  end

  def order_with_tax(tax_rates, order) do
    net_amount = order[:net_amount]
    Keyword.put(order, :total_amount, net_amount+tax_for_order(tax_rates, order) )
  end

  def tax_for_order(tax_rates, order) do
    tax_rate = Keyword.get(tax_rates, order[:ship_to], 0)
    order[:net_amount] * tax_rate
  end
end