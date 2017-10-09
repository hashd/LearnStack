defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 52 cards" do
    assert Cards.create_deck |> length == 52
  end
end
