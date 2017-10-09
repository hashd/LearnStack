defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @suits   [:spade, :heart, :diamond, :club]
  @symbols [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :joker, :queen, :king]

  @doc """
  Creates a deck of playing cards
  """
  def create_deck do
    for suit <- @suits, symbol <- @symbols do
      {suit, symbol}
    end
  end

  def shuffle(deck) do
    Enum.shuffle deck
  end

  @doc """
  Divides a deck into a hand of a given `hand_size` and the remaining deck

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      [spade: :ace]

  """
  def deal(deck, hand_size) when is_integer hand_size do
    deal(deck, [], hand_size)
  end

  def create_hand(count) when is_integer count do
    create_deck()
    |> shuffle
    |> deal(count)
  end

  @doc """
  Determines whether a deck contains the given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, {:heart, :three})
      true

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, {:space, :king})
      false

  """
  def contains?(             [], _card), do: false
  def contains?([ card | _rest],  card), do: true
  def contains?([_head |  rest],  card), do: contains?(rest, card)

  def save(deck, filename) do
    binary = :erlang.term_to_binary deck
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, content} -> :erlang.binary_to_term(content)
      {_, _r}        -> "That file doesn't exist."
    end
  end

  defp deal(deck, hand, number) when length(hand) == number, do: {hand |> Enum.reverse, deck}
  defp deal([head | rest], hand, number), do: deal(rest, [head | hand], number)
  defp deal([], _hand, _number), do: throw(:not_enough_cards_to_deal)
end
