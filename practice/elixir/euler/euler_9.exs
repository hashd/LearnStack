defmodule Euler9 do
  def solve(sum \\ 1000) do
    triplets = for a <- sum..1, b <- sum..a, sum - a - b > 0, a * a + b * b == (sum - a - b) * (sum - a - b), do: a * b * (sum - a - b)
    hd(triplets)
  end
end

Euler9.solve