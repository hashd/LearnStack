defmodule Euler32 do
  @digits [1,2,3,4,5,6,7,8,9]

  defp next_digit(n) when n < 10, do: {n, nil}
  defp next_digit(n) when is_integer(n), do: {rem(n,10), div(n,10)}
  defp next_digit(_n), do: nil

  defp digits(n), do: Stream.unfold(n, &next_digit/1) |> Enum.take_while(fn _val -> true end)

  defp has_pandigital_factors?(n, digits) do
    pandigital_factors = 2..trunc(:math.sqrt(n))
      |> Stream.filter(&(rem(n, &1) == 0))
      |> Stream.filter(fn val -> 
        List.flatten([digits(val), digits(div(n, val)), digits(n)])
        |> Enum.sort
        |> :erlang.==(digits)
      end)
      |> Enum.take(1)

    pandigital_factors != []
  end

  defp has_unique_digits?(n) do
    n_digits = (n |> digits)
    n_digits |> Enum.uniq == n_digits
  end

  def solve(digits \\ @digits) do
    1..1_000_000
    |> Stream.filter(&has_unique_digits?/1)
    |> Stream.filter(&(has_pandigital_factors?(&1, digits)))
    |> Enum.sum
  end
end

Euler32.solve