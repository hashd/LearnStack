defmodule MyList do
  def mapsum([], _), do: 0
  def mapsum([ head | tail], func), do: func.(head) + mapsum(tail, func)

  def max([]), do: 0
  def max([head | tail]), do: max(head, max(tail))

  def caesar([], _), do: []
  def caesar([head | tail], n), do: [min(head+n,122) | caesar(tail, n)]

  def span(from, to) when from === to, do: []
  def span(from, to) when from > to, do: IO.puts "From cant be greater than To"
  def span(from, to), do: [ from | span(from+1, to)]
end