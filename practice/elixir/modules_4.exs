defmodule MyRange do
  def between(a..b), do: between(a..b, [])

  def between(a..a, acc), do: [a | acc] |> Enum.reverse
  def between(a..b, acc) when a < b, do: between(a+1..b, [a | acc])
  def between(a..b, acc) when a > b, do: between(a-1..b, [a | acc])
end

MyRange.between(5..1)
MyRange.between(1..5)