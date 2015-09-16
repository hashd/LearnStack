defmodule Euler16 do
  defp pow(x, n) when is_integer(x) and is_integer(n) and n >= 0, do: pow(x, n, 1)

  defp pow(_x, 0, acc), do: acc
  defp pow(x, 1, acc), do: x * acc
  defp pow(x, n, acc) when rem(n, 2) == 0, do: pow(x * x, div(n, 2), acc)
  defp pow(x, n, acc) when rem(n, 2) == 1, do: pow(x * x, div(n - 1, 2), acc * x)

  def solve(a \\ 2, b \\ 1000) do
    pow(a, b)
    |> Integer.to_string
    |> Stream.unfold(&String.next_codepoint/1)
    |> Stream.map(&(&1 |> Integer.parse |> elem(0)))
    |> Enum.sum
  end
end

Euler16.solve