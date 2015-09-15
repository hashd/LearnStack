defmodule Functions do
  def dumb_function do
    fn -> end
  end

  def adder(x) do
    fn y -> x + y end
  end

  def operator(:add, x), do: fn y -> x + y end
  def operator(:sub, x), do: fn y -> x - y end
  def operator(:mul, x), do: fn y -> x * y end
  def operator(:div, x), do: fn y -> x / y end

  def operate(fun, x, y) do
    fun.(x, y)
  end
end