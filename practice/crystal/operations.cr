def operate(operator, a, b)
  if operator == :+
    a + b
  elsif operator == :*
    a * b
  elsif operator == :-
    a - b
  elsif operator == :/
    a / b
  end 
end

def add(a, b)
  operate(:+, a, b)
end

def mul(a, b)
  operate(:*, a, b)
end

def div(a, b)
  operate(:/, a, b)
end

def sub(a, b)
  operate(:-, a, b)
end

puts "#{add(5, 10)}"
puts "#{mul(5, 10)}"
puts "#{div(5, 10)}"
puts "#{sub(5, 10)}"