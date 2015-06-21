fizzbuzz_test = fn 
  0,  0, _n -> "FizzBuzz"
  0, _v, _n -> "Fizz"
  _v, 0, _n -> "Buzz"
  _, _, n -> n
end

fizzbuzz_test_ab = fn a, b -> 
  Enum.map a..b, fn n ->
    fizzbuzz_test.(rem(n, 3), rem(n, 5), n)
  end
end

fizzbuzz_test_ab.(1,50)

defmodule Fizzbuzz do
  def test(0,0,_), do: "Fizzbuzz"
  def test(0,_,_), do: "Fizz" 
  def test(_,0,_), do: "Buzz" 
  def test(_,_,n), do: n 
  def testRange(a,b) do
    for i <- a..b, do: test(rem(i,3), rem(i,5), i)
  end
end