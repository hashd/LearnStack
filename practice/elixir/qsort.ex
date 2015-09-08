defmodule Comprehensions do
  def qsort([]), do: []
  def qsort([p | r]) do
    lt = for ele <- r, ele  < p, do: ele
    gt = for ele <- r, ele >= p, do: ele
    
    qsort(lt) ++ [p] ++ qsort(gt)
  end

  def enum_qsort([]), do: []
  def enum_qsort([p | r]) do
    {lt, gt} = r |> Enum.partition(&(&1 < p))

    qsort(lt) ++ [p] ++ qsort(gt)
  end

  def perms([]), do: [[]]
  def perms(list) do
    for ele <- list, rest <- perms(list -- [ele]), do: [ele | rest]
  end
end

1..100 |> Enum.shuffle |> Comprehensions.qsort
1..4 |> Enum.shuffle |> Comprehensions.perms