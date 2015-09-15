defmodule Euler6 do
  def solve(a..b \\ 1..100) do
    square_of_sums = a..b |> Enum.sum |> :math.pow(2) |> trunc
    sum_of_squares = a..b |> Enum.map(&(:math.pow(&1, 2) |> trunc)) |> Enum.sum

    square_of_sums - sum_of_squares
  end
end

Euler6.solve