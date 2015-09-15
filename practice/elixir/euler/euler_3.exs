defmodule Euler3 do
  def solve(number \\ 600851475143) do
    number
    |> :math.sqrt
    |> trunc
    |> Range.new(1)
    |> Stream.filter(&(rem(number, &1) == 0))
    |> Stream.filter(fn val -> 
      factors = 2..trunc(:math.sqrt(val))
        |> Enum.filter(&(rem(val, &1) == 0))
        |> Enum.filter(&(&1 != 1))
      factors == []
    end)
    |> Enum.take(1)
  end
end

Euler3.solve