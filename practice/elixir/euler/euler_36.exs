defmodule Euler36 do
  defp next_digit(n) when n < 10, do: {n, nil}
  defp next_digit(n) when is_integer(n), do: {rem(n,10), div(n,10)}
  defp next_digit(_n), do: nil

  defp digits(n), do: Stream.unfold(n, &next_digit/1) |> Enum.take_while(fn _val -> true end)

  defp binary_rep(n), do: binary_rep(n, [])
  defp binary_rep(0, []), do: [0]
  defp binary_rep(0, acc), do: acc |> Enum.reverse
  defp binary_rep(n, acc), do: binary_rep(div(n,2), [rem(n,2)|acc])

  defp is_palindromic?(list) when is_list(list), do: list == list |> Enum.reverse

  def solve(limit \\ 1_000_000) do
    1..limit
    |> Stream.filter(&(&1 |> digits |> is_palindromic?))
    |> Stream.filter(&(&1 |> binary_rep |> is_palindromic?))
    |> Enum.sum
  end
end

Euler36.solve