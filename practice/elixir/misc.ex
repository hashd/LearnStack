def num_to_list(n) do
	1..n |> Enum.to_list |> Enum.map(&to_string/1) |> Enum.reduce(fn ele, acc -> acc <> "," <> ele end)
end

def fib(n) do
  {0, 1} |> Stream.unfold(fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(n)
end

def palindrome?(string) do
  trimmed_string = string |> String.graphemes |> Enum.filter(fn char -> (char != String.downcase(char)) and (char != String.upcase(char)) end)
  trimmed_string == trimmed_string |> Enum.reverse
end

def anagram?(a, b) do
  sorted_a = a |> String.graphemes |> Enum.sort(fn (c, d) -> c < d end)
  sorted_b = b |> String.graphemes |> Enum.sort(fn (c, d) -> c < d end)
  sorted_a == sorted_b
end

def extract_bytes(binary, num) do
  num = num * 8
  <<x::size(num),_y>> = binary
  x
end

def find_missing_char([h | t] = list) do
  lowercase_letters = 'abcdefghijklmnopqrstuvwxyz'
  uppercase_letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  result = if (h >= ?a and h <= ?z), do: (lowercase_letters -- list), else: (uppercase_letters -- list)
  case result do
    [] -> nil
    [h | _] -> h
    all -> all
  end
end

def join(tuple, sep) do
  t_size = tuple_size(tuple) - 1
  values = for i <- 0..t_size, do: elem(tuple, i)
  values |> Enum.reduce(fn ele, acc -> to_string(acc) <> sep <> to_string(ele) end) 
end

def anagrams(strings) do
  strings 
  |> Enum.sort_by(fn string -> string |> String.graphemes |> Enum.sort |> to_string end)
  |> Enum.chunk_by(fn string -> string |> String.graphemes |> Enum.sort end)
end

def to_hex(num) do
  to_hex(num, [])
end

defp to_hex(num, list) when div(num, 16) == 0, do: [ num | list] |> Enum.reverse
defp to_hex(num, list) do
  cond do
    rem(num, 16) > 9 -> 
      hexa_code = [65 + div(num,)]
      []