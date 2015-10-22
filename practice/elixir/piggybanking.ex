defmodule TorchBridge do
  defp total_time(list) when length(list)  < 3, do: List.last(list)
  defp total_time([a, b, c | []] = list) when length(list) == 3, do: a + b + c
  defp total_time([h1, h2 | t] = list) do
    [t1, t2 | rt] = (list |> Enum.reverse)

    n = length(list)
    tmp1 = t1 + h1 + t2 + h1
    tmp2 = h2 + h1 + t1 + h2

    cond do
      tmp1  < tmp2 -> tmp1 + total_time(list |> Enum.take(n-2))
      tmp1 >= tmp2 -> tmp2 + total_time(list |> Enum.take(n-2))
    end
  end

  def find_optimal_time(list) do
    list |> Enum.sort |> total_time
  end
end