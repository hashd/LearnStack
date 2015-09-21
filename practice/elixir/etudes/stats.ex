defmodule Stats do
  def minimum([]), do: nil
  def minimum([h | t]), do: minimum(t, h)

  defp minimum([], min), do: min
  defp minimum([h | t], min) when h < min, do: minimum(t, h)
  defp minimum([h | t], min) when h >= min, do: minimum(t, min)

  def maximum([]), do: nil
  def maximum([h | t]), do: maximum(t, h)

  defp maximum([], min), do: min
  defp maximum([h | t], min) when h > min, do: maximum(t, h)
  defp maximum([h | t], min) when h <= min, do: maximum(t, min)

  def range([]), do: nil
  def range([h | t]), do: range(t, {h, h})

  defp range([], range_tuple), do: range_tuple
  defp range([h | []], {min, max}) when h < min, do: {h, max}
  defp range([h | []], {min, max}) when h >= max, do: {min, h}
  defp range([_h | []], {min, max}), do: {min, max}
  defp range([h1, h2 | t], {min, max}) when h1 < h2 do
    case {h1 < min, h2 > max} do
      {true, false} -> range(t, {h1, max})
      {false, true} -> range(t, {min, h2})
      {false, false} -> range(t, {min, max})
      {true, true} -> range(t, {h1, h2})
    end
  end
  defp range([h1, h2 | t], {min, max}) when h1 >= h2 do
    case {h2 < min, h1 > max} do
      {true, false} -> range(t, {h2, max})
      {false, true} -> range(t, {min, h1})
      {false, false} -> range(t, {min, max})
      {true, true} -> range(t, {h2, h1})
    end
  end
end

# Stream.repeatedly(fn -> :random.uniform(1000) end) |> Enum.take(100) |> Stats.range