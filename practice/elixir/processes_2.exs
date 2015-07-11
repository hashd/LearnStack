defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n+1
    end
  end

  def create_processes(n) do
    last = 1..n |> Enum.reduce(self, fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end)

    send last, 0

    receive do
      answer when is_integer(answer) -> "Result is #{inspect(answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end