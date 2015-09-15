defmodule Euler4 do
  def solve do
    products = for a <- 999..100, b <- 999..a, do: a * b

    products
    |> Enum.filter(fn val -> 
      str = Integer.to_string(val)
      str == String.reverse str
    end)
    |> Enum.max
  end
end

Euler4.solve