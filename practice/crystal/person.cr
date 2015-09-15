class Person
  @name :: String
  @age :: Int32
  @gender :: Symbol

  def initialize(name, age, gender)
    @name = name
    @age = age
    @gender = gender
  end

  def name
    @name
  end

  def age
    @age
  end

  def gender
    @gender
  end
end

kiran = Person.new "Kiran", 27, :male
puts "#{kiran.name}, #{kiran.age}, #{kiran.gender}"