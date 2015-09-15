defmodule GuessingGame do
  def start(low \\ 1, high \\ 100) when low < high do
    number = :rand.uniform(high - low) + 1
    guess_loop(low, high, number)
  end

  defp guess_loop(low, high, number) do
    IO.puts "Guess the number between #{low}-#{high}"
    case get_input(:int) |> validate_input(number) do
      {:low, guess} -> 
        IO.puts "Your guess #{guess} is low"
        guess_loop(low, high, number)
      {:high, guess} ->
        IO.puts "Your guess #{guess} is high"
        guess_loop(low, high, number)
      {:equal, guess} ->
        IO.puts "You guessed it right! The number was #{number}"
    end
  end

  defp get_input(:int) do
    IO.read(:line) |> String.strip(?\n) |> Integer.parse |> elem(0)
  end

  defp validate_input(input, number) when input < number, do: {:low, input}
  defp validate_input(input, number) when input > number, do: {:high, input}
  defp validate_input(number, number), do: {:equal, number}
end

GuessingGame.start