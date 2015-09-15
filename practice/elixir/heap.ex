defmodule Heap do
  def max_of_min(list, size) when is_list(list) and size < length(list) do
    list
    |> Enum.chunk(size)
    |> Enum.map(&Enum.min/1)
    |> Enum.max
  end
end