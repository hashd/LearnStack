defmodule MyMath do
  def pow(a, n) when n >= 0, do: pow(a, n, 1)
  def pow(a, n) when n < 0, do: 1/pow(a, n, 1)

  defp pow(_a, 0, acc), do: acc
  defp pow(a, n, acc), do: pow(a, n-1, acc * a)
end