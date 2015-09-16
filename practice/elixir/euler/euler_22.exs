defmodule Euler22 do
  def solve(path_to_file \\ "resources/euler22.txt") do
    path_to_file
    |> File.read!
    |> String.replace("\"", "")
    |> String.split(",")
    |> Enum.sort
    |> Enum.map(fn str -> 
      str
      |> String.downcase
      |> Stream.unfold(&String.next_codepoint/1)
      #|> Stream.each(&IO.inspect/1)
      |> Stream.map(&((&1 |> String.to_char_list |> hd) - ?a + 1))
      |> Enum.sum
    end)
    |> Enum.with_index
    |> Enum.map(fn {val, idx} -> val * (idx + 1) end)
    |> Enum.sum
  end
end

Euler22.solve