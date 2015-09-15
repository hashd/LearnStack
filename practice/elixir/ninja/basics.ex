defmodule Basic do
  def greet(name) do
    IO.puts "Hi, #{name}"
  end

  def sum(a, b) do
    a + b
  end

  def operate(operation, a, b) when is_atom(operation) do
    case operation do
      :sum -> a + b
      :mul -> a * b
      :div -> a / b
      :sub -> a - b
    end
  end

  def new_operate(:sum, a, b), do: a + b
  def new_operate(:mul, a, b), do: a * b
  def new_operate(:div, a, b), do: a / b
  def new_operate(:sub, a, b), do: a - b
  def new_operate(:mod, a, b), do: rem(a, b)

  def fizzbuzz(a) when rem(a, 3) == 0 and rem(a, 5) == 0, do:  "FizzBuzz"
  def fizzbuzz(a) when rem(a, 3) == 0, do: "Fizz"
  def fizzbuzz(a) when rem(a, 5) == 0, do: "Buzz"
  def fizzbuzz(a), do: a

  def fizzbuzz(a, b) do
    Enum.map(a..b, &fizzbuzz/1)
  end

  def new_fizzbuzz(_num, 0, 0), do: "FizzBuzz"
  def new_fizzbuzz(_num, 0, _), do: "Fizz"
  def new_fizzbuzz(_num, _, 0), do: "Buzz"
  def new_fizzbuzz( num, _, _), do: num

  def new_fizzbuzz(a, b) do
    Enum.map(a..b, &(new_fizzbuzz(&1, rem(&1, 3), rem(&1, 5))))
  end

  def gcd(a, 0), do: a
  def gcd(0, b), do: b
  def gcd(a, b), do: gcd(b, rem(a, b))

  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-1) + fib(n-2)

  def sum_till(0), do: 0
  def sum_till(n), do: n + sum_till(n-1)
end