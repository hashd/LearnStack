defmodule FPSChapter3 do
  def fold_left([], acc, _fun), do: acc
  def fold_left([h | t], acc, fun), do: fold_left(t, fun.(h, acc), fun)
  
  def fold_right(list, acc, fun), do: list |> reverse |> fold_left(acc, fun)

  def sum(list) when is_list(list), do: fold_left(list, 0, fn ele, acc -> ele + acc end)
  def mul(list) when is_list(list), do: fold_left(list, 1, fn ele, acc -> ele * acc end)
  def len(list) when is_list(list), do: fold_left(list, 0, fn _ele, acc -> acc + 1 end)
  def reverse(list) when is_list(list), do: fold_left(list, [], fn ele, acc -> [ele | acc] end)
  def append(list, element) when is_list(list), do: fold_left(list, [], fn 
    ele, [] -> [ele, element]
    ele, list -> [ele | list]
  end) |> reverse

  def flatten([]), do: []
  def flatten([h | t]) when is_list(h), do: flatten(h) ++ flatten(t)
  def flatten([h | t]), do: [h | flatten(t)]
  def flatten(any), do: any

  def map([], _fun), do: []
  def map([h | t], fun), do: [fun.(h) | map(t, fun)]

  def filter([], _fun), do: []
  def filter([h | t], fun) do
    case fun.(h) do
      true -> [h | filter(t, fun)]
      _ -> filter(t, fun)
    end
  end

  def flat_map([], _fun), do: []
  def flat_map([h | t], fun), do: fun.(h) ++ flat_map(t, fun)

  def zip([], _list, _fun), do: []
  def zip(_list, [], _fun), do: []
  def zip([h1 | t1], [h2 | t2], fun), do: [fun.(h1, h2) | zip(t1, t2, fun)]
end