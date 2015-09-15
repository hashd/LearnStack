defmodule Euler2 do
  def solve(high \\ 4_000_000) do
    Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Enum.take_while(&(&1 < high))
    |> Enum.sum
  end
end

Euler2.solve