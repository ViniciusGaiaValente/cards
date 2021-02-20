defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "'create_deck' function makes 52 cards" do
    assert Enum.count(Cards.create_deck()) == 52
  end

  test "'shuffle' function properly shuffles a deck" do
    deck = Cards.create_deck()
    refute deck === Cards.shuffle(deck)
  end

end
