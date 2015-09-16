defmodule Euler17 do
  @zero_to_nine {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
  @ten_to_nineteen {"ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"}
  @tens {"zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"}
  
  defp in_words(n) when n < 10, do: @zero_to_nine |> elem(n)
  defp in_words(n) when n < 20, do: @ten_to_nineteen |> elem(n - 10)
  defp in_words(n) when n < 100 do
    case rem(n, 10) do
      0 -> "#{@tens |> elem(n |> div(10))}"
      _ -> "#{@tens |> elem(n |> div(10))} #{n |> rem(10) |> in_words}" 
    end 
  end
  defp in_words(n) when n < 1_000 do
    case rem(n, 100) do
      0 -> "#{n |> div(100) |> in_words} hundred"
      _ -> "#{n |> div(100) |> in_words} hundred and #{n |> rem(100) |> in_words}"
    end
  end
  defp in_words(n) when n < 1_000_000 do
    case rem(n, 1000) do
      0 -> "#{n |> div(1000) |> in_words} thousand"
      _ -> "#{n |> div(1000) |> in_words} thousand and #{n |> rem(1000) |> in_words}"
    end
  end

  def solve(n \\ 1000) do
    1..n
    |> Stream.map(&in_words/1)
    |> Stream.map(&(String.replace(&1, " ", "")))
    |> Stream.map(&String.length/1)
    |> Enum.sum
  end
end

Euler17.solve