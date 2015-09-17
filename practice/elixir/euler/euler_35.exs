defmodule Euler35 do
  def is_prime?(1), do: false
  def is_prime?(2), do: true
  def is_prime?(val) when val > 2 do
    factors = 2..trunc(:math.sqrt(val))
      |> Stream.filter(&(rem(val, &1) == 0))
      |> Stream.filter(&(&1 != 1))
      |> Enum.take(1)

    factors == []
  end

  defp next_digit(n) when n < 10, do: {n, nil}
  defp next_digit(n) when is_integer(n), do: {rem(n,10), div(n,10)}
  defp next_digit(_n), do: nil

  defp digits(n), do: Stream.unfold(n, &next_digit/1) |> Enum.take_while(fn _val -> true end)

  defp circular_numbers(integers, original, acc \\ [])
  defp circular_numbers([h | t] = integers, integers, []), do: circular_numbers(t ++ [h], integers, [integers])
  defp circular_numbers(integers, integers, acc), do: acc
  defp circular_numbers([h | t]= integers, original, acc), do: circular_numbers(t ++ [h], original, [integers | acc])

  def is_circular_prime?(number) do
    digits = number |> digits
    non_primes = circular_numbers(digits, digits)
      |> Stream.map(fn digits ->
        digits |> Enum.reduce(fn val, acc -> acc * 10 + val end)
      end)
      |> Stream.filter(&(!is_prime?(&1)))
      |> Enum.take(1)

    non_primes == []
  end

  def solve(limit \\ 1_000_000) do
    1..limit
    |> Stream.filter(&(rem(&1, 2) != 0 && rem(&1, 3) != 0))
    |> Stream.filter(&is_circular_prime?/1)
    |> Stream.each(&IO.inspect/1)
    |> Enum.count
  end
end

Euler35.solve