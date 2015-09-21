defmodule Alphabets do
  @num_alphabets  26
  @num_characters @num_alphabets + 1

  def stream do
    0
    |> Stream.iterate(&(&1+1))
    |> Stream.filter(&no_zero?/1)
    |> Stream.map(&to_charlist/1)
  end

  def to_charlist(number, acc \\ [])
  def to_charlist(0, acc), do: acc
  def to_charlist(n, acc), do: to_charlist(div(n, @num_characters), [ ?A + rem(n, @num_characters) - 1 | acc ])

  def no_zero?(0), do: false
  def no_zero?(number) when number > 0 and number < @num_characters, do: true
  def no_zero?(number) when number >= @num_characters do
    (rem(number, @num_characters) != 0) and no_zero?(div(number, @num_characters)) 
  end
end