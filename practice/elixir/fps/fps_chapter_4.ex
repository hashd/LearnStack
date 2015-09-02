defmodule FPSChapter4 do
  def variance([]), do: nil
  def variance(list) when is_list(list) do
    list
    |> Enum.map(&(&1*&1))
    |> Enum.reduce(&(&1+&2))
    |> :erlang./(length(list))
  end
end