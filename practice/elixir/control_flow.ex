defmodule ControlFlow do
  def fUpto(n) do
    1..n |> Enum.map(&fizzbuzz/1)
  end
  def fizzbuzz(a) do
    case {rem(a,3), rem(a,5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      {_, _} -> a
    end
  end
  def ok!(a) do
    case a do
      {:ok, data} -> data
      {atom ,_} -> raise "Unrecognized atom #{atom}"
      _ -> raise "Invalid parameter #{a}"
    end
  end
end