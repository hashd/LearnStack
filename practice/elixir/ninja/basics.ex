defmodule Basic do
  def greet(name) do
    IO.puts "Hi, #{name}"
  end

  def sum(a, b) do
    a + b
  end

  def fizzbuzz(a) when rem(a, 3) == 0 and rem(a, 5) == 0, do:  "FizzBuzz"
  def fizzbuzz(a) when rem(a, 3) == 0, do: "Fizz"
  def fizzbuzz(a) when rem(a, 5) == 0, do: "Buzz"
  def fizzbuzz(a), do: a

  def gcd(a, 0), do: a
  def gcd(0, b), do: b
  def gcd(a, b), do: gcd(b, rem(a, b))
end