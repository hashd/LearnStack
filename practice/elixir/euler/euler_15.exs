defmodule Euler15 do
  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: __MODULE__)
  end

  defp solve_for_point({0, 0}), do: 0
  defp solve_for_point({1, 0}), do: 1
  defp solve_for_point({0, 1}), do: 1
  defp solve_for_point({0, y}), do: cached_answer({0, y - 1})
  defp solve_for_point({x, 0}), do: cached_answer({x - 1, 0})
  defp solve_for_point({x, y}) do
    cached_answer({x - 1, y}) + cached_answer({x, y - 1})
  end

  defp cached_answer(point) do
    case Agent.get(__MODULE__, &(Dict.get(&1, point))) do
      nil -> 
        result = solve_for_point(point)
        Agent.get_and_update(__MODULE__, fn cache -> 
          {result, Dict.put_new(cache, point, result)}
        end)
      answer -> answer
    end
  end

  def solve(n \\ 20) do
    start_link
    solve_for_point({n, n})
  end
end

Euler15.solve