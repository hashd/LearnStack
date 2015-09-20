defmodule Factor do
  def number_stream, do: Stream.iterate(0, &(&1 + 1))

  def factor_stream(num) do
    1..trunc(:math.sqrt(num))
    |> Stream.filter(fn n -> rem(num, n) == 0 end)
    |> Stream.map(fn n -> {n, div(num, n)} end)
  end

  def prime_stream, do: number_stream |> Stream.filter(&prime?/1)

  def prime?(num) when num < 2, do: false
  def prime?(num) when num < 4, do: true
  def prime?(num) do
    num
    |> factor_stream
    |> Stream.filter(fn 
        {1, _} -> false
             _ -> true 
      end)
    |> Enum.empty?
  end

  def primes(num), do: primes(1, num)
  def primes(a, b), do: a..b |> Enum.filter(&prime?/1)

  def primes_till(num), do: num |> primes |> Enum.count
end