defmodule CsvSigil do
  def sigil_v(lines, []), do: parse(lines,",")
  def sigil_v(lines, delimiter), do: parse(lines,"#{delimiter}")

  defp parse(lines, delimiter) do
    lines
    |> String.rstrip
    |> String.split("\n")
    |> Enum.map &(String.split &1, delimiter)
  end
end