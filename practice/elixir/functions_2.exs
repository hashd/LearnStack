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