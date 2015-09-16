defmodule Euler27 do
  defp is_prime?(n) when n < 0, do: is_prime?(-n)
  defp is_prime?(0), do: false
  defp is_prime?(1), do: false
  defp is_prime?(2), do: true
  defp is_prime?(val) when val > 2 do
    factors = 2..trunc(:math.sqrt(val))
      |> Stream.filter(&(rem(val, &1) == 0))
      |> Stream.filter(&(&1 != 1))
      |> Enum.take(1)

    factors == []
  end

  def primes_till(n \\ 1000) do
    1..n |> Enum.filter(&is_prime?/1)
  end

  def solve(limit \\ 1000) do
    limit
    |> primes_till
    |> Enum.flat_map(&([&1, -&1]))
    |> Enum.map(fn b -> 
      -(limit-1)..(limit-1)
      |> Enum.map(fn a ->
        num_of_primes = 0..limit
          |> Stream.map(fn n -> n * n + a * n + b end)
          |> Enum.take_while(&is_prime?/1)
          |> length
        {num_of_primes, a}
      end)
      |> Enum.map(fn {d, i} -> {d, i, b} end)
      |> Enum.max_by(&(elem(&1, 0)))
    end)
    |> Enum.max_by(&(elem(&1, 0)))
  end
end

Euler27.solve