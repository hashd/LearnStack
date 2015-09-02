defmodule FPSChapter5 do
  def constant(n), do: Stream.cycle([n])
  def constant_unfold(n), do: Stream.unfold(n, &({&1, &1}))
  def constant_resource(n) do
    Stream.resource(fn -> n end, fn n -> {[n], n} end, fn n -> nil end)
  end

  def from(n), do: Stream.iterate(n, &(&1 + 1))
  def from_unfold(n), do: Stream.unfold(n, &({&1, &1+1}))
  def from_resource(n) do
    Stream.resource(fn -> n end, &({[&1], &1+1}), fn n -> nil end)
  end

  def fibs, do: Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a+ b}} end)
  def fibs_resource do
    Stream.resource(fn -> {0, 1} end, fn {a, b} -> {[a], {b, a + b}} end, fn n -> nil end)
  end
end