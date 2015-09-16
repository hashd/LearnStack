defmodule Euler12 do
  def num_of_factors(num) do
    1..trunc(:math.sqrt(num))
    |> Enum.filter(&(rem(num, &1) == 0))
    |> length
  end

  def num_of_divisors(num) do
    integer_sqrt = num |> :math.sqrt |> trunc
    case integer_sqrt * integer_sqrt == num do
      true  -> 2 * num_of_factors(num) - 1
      false -> 2 * num_of_factors(num)
    end
  end
  
  def solve(n \\ 500) do
    Stream.unfold({0, 1}, fn {a, b} -> {a + b, {a + b, b + 1}} end)
    |> Stream.map(&({&1, num_of_divisors(&1)}))
    |> Stream.filter(&(elem(&1, 1) >= n))
    |> Enum.take(1)
    |> hd
  end
end

Euler12.solve