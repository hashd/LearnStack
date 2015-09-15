n = 100
results = (0..n).map do |num|
  case 
  when num % 3 == 0 && num % 5 == 0
    "Fizzbuzz"
  when num % 3 == 0
    "Fizz"
  when num % 5 == 0
    "Buzz"
  else
    num
  end
end
puts "#{results}"