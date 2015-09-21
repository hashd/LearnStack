defmodule Seven do
  
  def traverse(tuple) when is_tuple(tuple), do: traverse(tuple, 1)

  def traverse(tuple, depth) do
    size = tuple_size(tuple)
    
    0..(size-1)
    |> Enum.each(fn idx -> 
      case elem(tuple, idx) do
        val when is_binary(val) ->
          1..depth |> Enum.each(fn _ -> IO.write "  " end)
          IO.puts val
        val when is_tuple(val) ->
          traverse(val, depth + 1)
        _ -> IO.puts "Unknown entity found during traversal"
      end
    end)
  end

end