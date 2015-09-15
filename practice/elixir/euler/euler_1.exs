defmodule Euler1 do
  def solve(a..b) do
    a..b
    |> Enum.filter(fn val -> rem(val, 3) == 0 or rem(val, 5) == 0 end)
    |> Enum.sum
  end
end

Euler1.solve(0..1000)