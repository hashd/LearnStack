defmodule Euler30 do
  @digits [0,1,2,3,4,5,6,7,8,9]

  defp pow(x, n) when is_integer(x) and is_integer(n) and n >= 0, do: pow(x, n, 1)

  defp pow(_x, 0, acc), do: acc
  defp pow(x, 1, acc), do: x * acc
  defp pow(x, n, acc) when rem(n, 2) == 0, do: pow(x * x, div(n, 2), acc)
  defp pow(x, n, acc) when rem(n, 2) == 1, do: pow(x * x, div(n - 1, 2), acc * x)

  defp next_digit(n) when n < 10, do: {n, nil}
  defp next_digit(n) when is_integer(n), do: {rem(n,10), div(n,10)}
  defp next_digit(n), do: nil

  def solve do
    2..295245
    |> Stream.filter(fn val -> 
      digits_sum = Stream.unfold(val, &next_digit/1)
      |> Stream.map(&(pow(&1, 5)))
      |> Enum.sum

      digits_sum == val
    end)
    |> Enum.sum
  end
end

Euler30.solve