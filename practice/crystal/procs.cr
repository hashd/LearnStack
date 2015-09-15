identity = ->(x: Int64) {x}
add = Proc(Int32, Int32, Int32).new {|x, y| x + y}

puts "#{identity.call(5_i64)} and #{add.call(5,6)}"