defmodule ControlFlow do
  def fUpto(n), do: Enum.map(1..n, &fizzbuzz/1)

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
      {atom ,_} when is_atom(atom) -> raise "Unrecognized atom #{atom}"
      _ -> raise "Invalid parameter #{a}"
    end
  end
end

# ControlFlow.fUpto(500)