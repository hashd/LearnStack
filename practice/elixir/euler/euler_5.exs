defmodule Euler5 do
  def gcd(a, 0), do: a
  def gcd(0, b), do: b
  def gcd(a, b), do: gcd(b, rem(a, b))

  def lcm(a, b) when a == 0 or b == 0, do: 0
  def lcm(a, b), do: div(a * b, gcd(a, b))

  def solve(a..b \\ 1..20) do
    a..b |> Enum.reduce(&lcm/2)
  end
end

Euler5.solve