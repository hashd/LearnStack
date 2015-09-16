defmodule Euler14 do
  @limit 1_000_000
  def next_collatz_num(num) when rem(num, 2) == 0, do: div(num, 2)
  def next_collatz_num(num)                      , do: 3 * num + 1

  def start_link do
    Agent.start_link(fn -> HashDict.new |> Dict.put_new(1, 1) end, name: __MODULE__)
  end

  def answer_for(num) do
    answer = Agent.get(__MODULE__, &(Dict.get(&1, num)))
    case answer do
      nil -> 
        seq_length = num |> next_collatz_num |> answer_for
        Agent.get_and_update(__MODULE__, fn state -> 
          {seq_length + 1, Dict.put_new(state, num, seq_length + 1)}
        end)
      _   -> answer
    end
  end

  def solve(limit \\ @limit) do
    Euler14.start_link

    1..limit
    |> Stream.map(&({&1, answer_for(&1)}))
    |> Stream.each(&IO.inspect/1)
    |> Enum.sort_by(&(elem(&1, 1)))
    |> Enum.reverse
    |> hd
  end
end

Euler14.solve