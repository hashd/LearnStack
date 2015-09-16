defmodule Euler28 do
  def solve(lvl \\ 1001)
  def solve(1), do: 1
  def solve(lvl) do
    2..div(lvl+1, 2)
    |> Enum.flat_map(fn lvl ->
      base = (2*lvl - 3) * (2*lvl - 3)
      add  = 2*(lvl - 1)

      [base + add, base + 2 * add, base + 3 * add, base + 4 * add]
    end)
    |> Enum.sum
    |> :erlang.+(1)
  end
end