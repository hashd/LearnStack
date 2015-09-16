defmodule Euler29 do
  defp pow(x, n) when is_integer(x) and is_integer(n) and n >= 0, do: pow(x, n, 1)

  defp pow(_x, 0, acc), do: acc
  defp pow(x, 1, acc), do: x * acc
  defp pow(x, n, acc) when rem(n, 2) == 0, do: pow(x * x, div(n, 2), acc)
  defp pow(x, n, acc) when rem(n, 2) == 1, do: pow(x * x, div(n - 1, 2), acc * x)

  def solve(limit \\ 100) do
    powers = for a <- 2..limit, b <- 2..limit, do: pow(a, b)

    powers
    |> Enum.uniq
    |> Enum.count
  end
end

Euler29.solve