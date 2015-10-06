defmodule Combinations do
  def split(num, list), do: split(num, list |> Enum.sort, [])

  def split(0, _, acc), do: IO.inspect acc
  def split(num, [], acc), do: nil
  def split(num, _, _) when num < 0, do: nil
  def split(num, [h | t] = list, acc) when num < h, do: nil
  def split(num, [h | t] = list, acc) do
    split(num - h, list, [h | acc])
    split(num, t, acc)
  end
end

Combinations.split 50, [2,3,5]