defmodule UserDict do
  def start_link(path \\ "/usr/share/dict/words", dict_name \\ :user_dict) when is_bitstring(path) do
    Agent.start_link(fn ->
      File.stream!(path, [:read])
      |> Stream.map(fn (str) -> String.replace(str, "\n", "") end)
      |> Enum.take_while(fn (str) -> str !== "" end)
      |> Enum.reduce(%{}, fn (str, acc) ->
        Map.put_new(acc, str, true)
      end) 
    end, name: dict_name)
  end

  def check_word?(dict_name \\ :user_dict, word) when is_bitstring(word) do
    Agent.get(dict_name, fn map -> map[word] || false end)
  end
end

defmodule WordSplitter do
  def split(string) do
    split(string, [])
  end

  defp split("", words) do
    {:ok, words |> Enum.reverse |> IO.inspect}
  end

  defp split(string, words) do
    len = string |> String.length
    for i <- 2..len-1, i > 1, string |> String.slice(0..i) |> UserDict.check_word? do
      case split(String.slice(string, i+1..len), [ String.slice(string, 0..i) | words ]) do
        {:ok, list} -> list
        _ -> false
      end
    end
    |> Enum.filter(fn (res) -> 
      res !== false
    end)
  end
end

UserDict.start_link
WordSplitter.split("bedbathandbeyond")