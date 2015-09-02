defmodule Logic do
  import Kernel, except: [raise: 2]

  def raise(_a, 0), do: 1
  def raise(a, n) when is_integer(n) and n > 0, do: a * raise(a, n-1)
  def raise(a, n) when is_integer(n) and n < 0, do: 1/raise(a, -n)

  def tr_raise(a, n) when is_integer(n), do: tr_raise(a, n, 1)

  defp tr_raise(_a, 0, acc), do: acc
  defp tr_raise(a, n, acc) when n > 0, do: tr_raise(a, n-1, a * acc)
  defp tr_raise(a, n, 1 = acc) when n < 0, do: 1/tr_raise(a, -n, acc)
end