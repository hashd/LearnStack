defmodule Guesser do
  def guess(actual, range) do 
    guess(trunc((Enum.max(range)+Enum.min(range))/2), actual, range)
  end
  defp guess(current, actual, range) when current > actual do
    IO.puts "Is it #{current}?"
    guess(trunc((current-1+Enum.min(range))/2), actual, Enum.min(range)..current-1)
  end
  defp guess(current, actual, range) when current < actual do
    IO.puts "Is it #{current}?"
    guess(trunc((current+1+Enum.max(range))/2), actual, current+1..Enum.max(range))
  end
  defp guess(current, actual, range) when current === actual do
    IO.puts "Is it #{current}?"
    IO.puts current
  end
end