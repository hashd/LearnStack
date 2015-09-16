defmodule Euler34 do
  def fc(n) when is_integer(n) and n >= 0, do: fc(n, 1)

  defp fc(0, acc), do: acc
  defp fc(n, acc), do: fc(n-1, n * acc)

  defp next_digit(n) when n < 10, do: {n, nil}
  defp next_digit(n) when is_integer(n), do: {rem(n,10), div(n,10)}
  defp next_digit(_n), do: nil

  defp digits(n), do: Stream.unfold(n, &next_digit/1) |> Enum.take_while(fn _val -> true end)

  def solve do
    3..1_000_000
    |> Stream.map(&(Tuple.duplicate(&1, 2)))
    |> Stream.map(fn {x, y} -> {x, digits(y)} end)
    |> Stream.map(fn {x, y} -> {x, y |> Enum.map(&fc/1) |> Enum.sum} end)
    |> Stream.filter(fn {x, y} -> x == y end)
    |> Stream.map(fn {x, _y} -> x end)
    |> Enum.sum
  end
end