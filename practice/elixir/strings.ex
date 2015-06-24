defmodule MyString do
  def capitalize_sentences(str) when is_bitstring(str) do
    str |> String.split(~r{\.\s+}) |> Enum.map(&(String.capitalize(&1))) |> Enum.join(". ")
  end
end