(for i <- 3..10000, j <- 2..trunc(:math.sqrt(i)), j > 1, do: {i,j, rem(i,j)}) |> 
  (Enum.chunk_by &(Tuple.to_list(&1) |> List.first)) |> 
  Enum.map(&(List.zip(&1))) |> 
  Enum.map(fn ([a,_,c]) -> {(Tuple.to_list(a) |> List.first), (Tuple.to_list(c) |> Enum.reduce(1, fn (x,acc) -> x * acc end))} end) |> 
  Enum.filter(fn ({a,b}) -> b !== 0 end) 