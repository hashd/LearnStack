defmodule Euler24 do
  @digits [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  def perms([]), do: [[]]
  def perms(list) do
    for ele <- list, rest <- perms(list -- [ele]), do: [ele | rest]
  end

  def solve(list \\ @digits, n \\ 1_000_000) do
    list |> perms |> Enum.at(n - 1)
  end
end

Euler24.solve