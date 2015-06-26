defmodule Primes do
  def stupid_find(n) when n >= 2 do
    (for i <- 2..n, j <- 2..trunc(:math.sqrt(i)), j > 1, do: {i,j, rem(i,j)}) |> 
      (Enum.chunk_by &(Tuple.to_list(&1) |> List.first)) |> 
      Enum.map(&(List.zip(&1))) |> 
      Enum.map(fn ([a,_,c]) -> {(Tuple.to_list(a) |> List.first), (Tuple.to_list(c) |> Enum.reduce(1, fn (x,acc) -> x * acc end))} end) |> 
      Enum.filter(fn ({_,b}) -> b !== 0 end) |>
      Enum.map(fn ({a, _}) -> a end)
  end

  @doc """
  ## find
  Find prime numbers till n

  > Note that n has to be greater than 2

  ### Examples
  ```
  Primes.find(10)
  > [2,3,5,7]
  ```
  """
  def find(n) when n >= 2 do
    (2..n |> Enum.to_list) -- (for i <- 2..trunc(:math.sqrt(n)), j <- i..trunc(:math.sqrt(n)), j>=i, i*j < n, do: i*j)
  end
end