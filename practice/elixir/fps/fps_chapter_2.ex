defmodule Chapter2 do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-1) + fib(n-2)

  def isSorted([], _), do: true
  def isSorted([_h | []], _), do: true
  def isSorted([h1, h2 | t], f), do: f.(h1,h2) and isSorted([h2 | t], f)

  def drop(list, 0) when is_list(list), do: list
  def drop([], _n), do: raise "List too small for this operation"
  def drop([_h | t], n), do: drop(t, n-1)

  def drop_while([], _fun), do: []
  def drop_while([h | t] = list, fun) do
    case fun.(h) do
      true -> drop_while(t, fun)
      _ -> list
    end
  end

  def set_head([], val), do: [val]
  def set_head([_h | t], val), do: [val | t]

  def init([]), do: raise "List too small"
  def init([_h | []]), do: []
  def init(list), do: init(list, [])

  defp init([_h | []], list), do: list |> Enum.reverse
  defp init([h | t], list), do: init(t, [h | list])

  def has_subsequence(parent, subsequence), do: has_subsequence(parent, subsequence, false)

  defp has_subsequence(_parent, [], _), do: true
  defp has_subsequence([], _list, _), do: false
  defp has_subsequence([ph | pt], [ph | st] = ss, false), do: has_subsequence(pt, st, true) or has_subsequence(pt, ss, false)
  defp has_subsequence([ph | pt], [ph | st] = _ss, true), do: has_subsequence(pt, st, true)
  defp has_subsequence([_ph | pt], ss, false), do: has_subsequence(pt, ss)
  defp has_subsequence([_ph | pt], _ss, true), do: false
end