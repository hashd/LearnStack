defmodule Euler7 do
  def is_prime(2), do: true
  def is_prime(val) when val > 2 do
    factors = 2..trunc(:math.sqrt(val))
      |> Stream.filter(&(rem(val, &1) == 0))
      |> Stream.filter(&(&1 != 1))
      |> Enum.take(1)

    factors == []
  end

  def solve(n \\ 10_001) do
    2..1_000_000_000_000
    |> Stream.filter(&is_prime/1)
    |> Enum.take(n)
    |> Enum.reverse
    |> hd
  end
end

Euler7.solve