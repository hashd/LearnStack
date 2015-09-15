defmodule Euler10 do
  def is_prime(1), do: false
  def is_prime(2), do: true
  def is_prime(val) when val > 2 do
    factors = 2..trunc(:math.sqrt(val))
      |> Stream.filter(&(rem(val, &1) == 0))
      |> Stream.filter(&(&1 != 1))
      |> Enum.take(1)

    factors == []
  end

  def solve(a..b \\ 1..2_000_000) do
    a..b
    |> Stream.filter(&is_prime/1)
    |> Enum.sum
  end
end

Euler10.solve