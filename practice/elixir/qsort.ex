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

    enum_qsort(lt) ++ [p] ++ enum_qsort(gt)
  end

  def par_qsort([]), do: []
  def par_qsort([p | r]) do
    {lt, gt} = r |> Enum.partition(&(&1 < p))

    lht = Task.async(fn -> par_qsort(lt) end)
    rht = Task.async(fn -> par_qsort(gt) end)

    Task.await(lht, 800000) ++ [p] ++ Task.await(rht, 800000)
  end

  def perms([]), do: [[]]
  def perms(list) do
    for ele <- list, rest <- perms(list -- [ele]), do: [ele | rest]
  end
end

:timer.tc(fn -> 1..1000000 |> Enum.shuffle |> Comprehensions.qsort end)
:timer.tc(fn -> 1..1000000 |> Enum.shuffle |> Comprehensions.par_qsort end)