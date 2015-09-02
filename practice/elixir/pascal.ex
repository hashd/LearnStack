defmodule Pascal do
  def print_levels(n) when is_integer(n) and n > 0 do
    print_level(1, n, [1])
  end

  defp print_level(n, n, cl_list), do: print(cl_list)
  defp print_level(cl, n, cl_list) do
    print(cl_list)
    print_level(cl + 1, n, calc_next_level(cl_list))
  end

  defp print(list) when is_list(list) do
    Enum.each(list, fn ele -> IO.write "#{ele} " end)
    IO.puts ""
  end

  defp calc_next_level([h | _t] = cl_list) do
    calc_next_level(cl_list, [h])
  end

  defp calc_next_level([], acc), do: Enum.reverse(acc)
  defp calc_next_level([h | []], acc), do: calc_next_level([], [h | acc])
  defp calc_next_level([h, ph | t], acc), do: calc_next_level([ph | t], [(h + ph) | acc])
end