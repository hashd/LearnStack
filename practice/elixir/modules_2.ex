defmodule Modules2 do
  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)

  def gcd(0,b), do: b
  def gcd(a,0), do: a
  def gcd(a,b), do: gcd(b,rem(a,b))
end