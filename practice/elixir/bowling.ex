defmodule Bowling do
  def total(scores) when is_list(scores) do
    score(:normal, 0, scores)
  end

  defp score(_, total, []), do: total
  defp score(:normal, total, [10 | scores]), do: score(:strike, total + 10, scores)
  defp score(:normal, total, [a, b | scores]) when a + b == 10, do: score(:spare, total + 10, scores)
  defp score(:normal, total, [a, b | scores]) when a + b > 10, do: raise "Impossible throws: #{a}, #{b}"
  defp score(:normal, total, [a, b | scores]), do: score(:normal, total + a + b, scores)
  defp score(:normal, total, [a | []]), do: raise "Incomplete throw: #{a}"
  defp score(:spare, total, [a | _list] = scores), do: score(:normal, total + a, scores)
  defp score(:strike, total, [a, b | _list] = scores), do: score(:normal, total + a + b, scores)
end