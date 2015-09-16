defmodule Euler31 do
  @denominations [1,2,5,10,20,50,100,200]

  def get_ways(_ds, 0), do: 1
  def get_ways([], _a), do: 0
  def get_ways([h | rest] = denominations, amount_left) when amount_left >= h do
    get_ways(denominations, amount_left - h) + get_ways(rest, amount_left)
  end
  def get_ways(_denominations, _amount_left), do: 0
  
  def solve(amount \\ 200, denominations \\ @denominations) do
    get_ways(denominations |> Enum.sort, amount)
  end
end

Euler31.solve(5)