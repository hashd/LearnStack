defmodule Poker do
  defmodule Card do
    @type suit :: :clubs | :diamonds | :hearts | :spades
    @type rank :: :ace | :king | :queen | :jack | 1..10
    @type t :: {rank, suit}

    @suits [:clubs, :diamonds, :hearts, :spades]
    @ranks [:ace, :king, :queen, :jack | (10..2 |> Enum.to_list)]

    @spec suits() :: [suit]
    def suits, do: @suits

    @spec ranks() :: [rank]
    def ranks, do: @ranks

    @spec sorter(t, t) :: boolean
    def sorter({lr, _}, {rr, _}) do
      rank_of(lr) <= rank_of(rr)
    end

    @spec compare(t, t) :: number
    def compare({lr, _}, {rr, _}) do
      rank_of(lr) - rank_of(rr)
    end

    @spec rank_of(rank) :: number
    defp rank_of(:ace), do: 14
    defp rank_of(:king), do: 13
    defp rank_of(:queen), do: 12
    defp rank_of(:jack), do: 11
    defp rank_of(n) when is_integer(n) and n in 1..10, do: n
  end

  defmodule Deck do
    alias Poker.Card, as: Card

    @type t :: [Card.t]

    @cards for rank <- Card.ranks, suit <- Card.suits, do: {rank, suit}

    @spec new() :: t
    def new do
      Agent.start_link(fn -> @cards end, name: __MODULE__)
    end

    @spec shuffle() :: t
    def shuffle(seed \\ :os.timestamp) do
      Agent.update(__MODULE__, fn deck -> Enum.shuffle(deck) end)
    end

    @spec get() :: t
    def get do
      Agent.get(__MODULE__, fn deck -> deck end)
    end

    @spec draw() :: Card.t
    def draw do
      Agent.get_and_update(__MODULE__, fn 
        [] -> {{:error, :empty_deck}, []}
        [h | t] -> {{:ok, h}, t} 
      end)
    end
  end
end
