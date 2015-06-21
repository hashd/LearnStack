defmodule MyStrings do
  def is_sq_string(list) when is_list(list), do: list |> Enum.filter(&(&1<?\s || &1>?~)) |> Enum.empty?
  def anagram?(w1, w2) when is_list(w1) and is_list(w2), do: Enum.sort(w1) === Enum.sort(w2)
  def anagram?(w1, w2) when is_bitstring(w1) and is_bitstring(w2), do: anagram?(String.to_char_list(w1), String.to_char_list(w2))
  def center(words) when is_list(words) do
    maxlength = words |> Enum.max_by(&String.length/1) |> String.length
    for word <- words do
      wordlength = String.length(word)
      word |> String.ljust(wordlength+round((maxlength-wordlength)/2)) |> String.rjust(maxlength) |> IO.inspect
    end
  end
end