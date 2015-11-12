# Ensure mimes.txt is the present working directory relative to the compilation of this script
defmodule Mime do
  for line <- File.stream!(Path.join([__DIR__, "mimes.txt"]), [], :line) do
    [type, rest] = line 
      |> String.split("\t") 
      |> Enum.map(&String.strip/1)

    extensions = String.split(rest, ~r/,\s?/)

    IO.write type

    def exts_from_type(unquote(type)), do: unquote(extensions)
    def type_from_ext(ext) when ext in unquote(extensions), do: unquote(type) 
  end

  def exts_from_type(_), do: []
  def type_from_ext(_), do: nil
  def valid_type?(type), do: exts_from_type(type) |> Enum.any?
end