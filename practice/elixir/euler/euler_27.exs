defmodule Euler27 do
  @spec is_prime?(non_neg_integer) :: boolean
  def is_prime?(val) when n < 2, do: false
  def is_prime?(val) when n < 4, do: true
  def is_prime?(val) when val >= 4 do
    2..trunc(:math.sqrt(val))
    |> Stream.filter(&(rem(val, &1) == 0))
    |> Enum.empty?
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