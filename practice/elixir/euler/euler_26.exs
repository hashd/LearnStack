defmodule Euler26 do
  def reciprocal_cycles(n) do
    Stream.unfold({10, n, []}, fn
      {0, _b, _list} -> nil
      {a, b, list} -> 
        case {div(a, b), rem(a,b)} in list do
          false -> {div(a, b), {rem(a,b)*10, b, [{div(a,b), rem(a,b)} | list]}}
          true  -> nil
        end
    end)
    |> Enum.count
  end

  def solve(limit \\ 1000) do
    2..(limit-1)
    |> Enum.map(&reciprocal_cycles/1)
    |> Enum.zip(2..(limit-1))
    |> Enum.max_by(&(elem(&1, 0)))
    |> elem(1)
  end
end

Euler26.solve