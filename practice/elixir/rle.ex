defmodule RLE do
  def encode(string) when is_bitstring(string) do
    string |> String.graphemes |> encode
  end

  def encode(graphemes) when is_list(graphemes) do
    graphemes = graphemes ++ ["\n"]
    graphemes |> List.foldl({"", "", 0}, fn 
      (ele, {rle_string, _, 0}) -> {rle_string, ele, 1}
      (ele, {rle_string, ele, count}) -> {rle_string, ele, count + 1}
      (ele, {rle_string, char, count}) -> {rle_string <> (Integer.to_string(count)) <> char, ele, 1}
    end) |> elem(0)
  end
end