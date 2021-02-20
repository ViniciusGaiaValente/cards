defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Create a full deck of playing cards, represented by a list of maps containing a suit and a value.
    Suits are represented by atoms and variate between ':diamonds', ':hearts', ':spades', :'clubs'.
    Values are represented by integers and go from 1 to 13.
    The returned deck contains all the 52 possible combinations of a suit and a value.
    The returned deck is ordered first by suits then by numbers as you can see in the example below.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> deck
      [
        %{suit: :diamonds, value: 1},
        %{suit: :diamonds, value: 2},
        %{suit: :diamonds, value: 3},
        %{suit: :diamonds, value: 4},
        %{suit: :diamonds, value: 5},
        %{suit: :diamonds, value: 6},
        %{suit: :diamonds, value: 7},
        %{suit: :diamonds, value: 8},
        %{suit: :diamonds, value: 9},
        %{suit: :diamonds, value: 10},
        %{suit: :diamonds, value: 11},
        %{suit: :diamonds, value: 12},
        %{suit: :diamonds, value: 13},
        %{suit: :hearts, value: 1},
        %{suit: :hearts, value: 2},
        %{suit: :hearts, value: 3},
        %{suit: :hearts, value: 4},
        %{suit: :hearts, value: 5},
        %{suit: :hearts, value: 6},
        %{suit: :hearts, value: 7},
        %{suit: :hearts, value: 8},
        %{suit: :hearts, value: 9},
        %{suit: :hearts, value: 10},
        %{suit: :hearts, value: 11},
        %{suit: :hearts, value: 12},
        %{suit: :hearts, value: 13},
        %{suit: :spades, value: 1},
        %{suit: :spades, value: 2},
        %{suit: :spades, value: 3},
        %{suit: :spades, value: 4},
        %{suit: :spades, value: 5},
        %{suit: :spades, value: 6},
        %{suit: :spades, value: 7},
        %{suit: :spades, value: 8},
        %{suit: :spades, value: 9},
        %{suit: :spades, value: 10},
        %{suit: :spades, value: 11},
        %{suit: :spades, value: 12},
        %{suit: :spades, value: 13},
        %{suit: :clubs, value: 1},
        %{suit: :clubs, value: 2},
        %{suit: :clubs, value: 3},
        %{suit: :clubs, value: 4},
        %{suit: :clubs, value: 5},
        %{suit: :clubs, value: 6},
        %{suit: :clubs, value: 7},
        %{suit: :clubs, value: 8},
        %{suit: :clubs, value: 9},
        %{suit: :clubs, value: 10},
        %{suit: :clubs, value: 11},
        %{suit: :clubs, value: 12},
        %{suit: :clubs, value: 13},
      ]

  """
  def create_deck do
    suits = [:diamonds, :hearts, :spades, :clubs]
    values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

    for suit <- suits, value <- values do
      %{suit: suit, value: value}
    end
  end

  @doc """

    Shuffles a deck into new one with the exact same cards but in a new and randomized order

      ## Examples

      iex> deck = Cards.create_deck
      iex> deck === Cards.shuffle(deck)
      false

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """

    Deal a hand of cards with the given size (the hand size represents how many cards are in it, 1 by default).
    Returns a tuple with the dealt hand on the first position and the rest of the deck on the second position.
    To compose a hand, cards are taken from the first positions of the deck.
    All the cards on the hand get removed from the deck.

  """
  def deal(deck, size \\ 1) do
    Enum.split(deck, size)
  end

    @doc """

    Create a new deck, shuffles it and deal a hand with the given hand_size

  """
  def create_and_deal(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end

  @doc """
    Check if a specific deck contains the given card

  ## Examples


      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, %{suit: :diamonds, value: 1})
      true

  """
  def contains?(hand, card) do
    Enum.member?(hand, card)
  end

  @doc """

    Save a deck to the file system

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """

    Load a deck from the file system

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "An error occurred"
    end
  end

  @doc """

    Check which of the 2 given cards has a bigger value.
    If the value is tied this function will consider the card with the bigger suit as the winner.
    ':diamond' is the biggest suit followed by: ':hearts', ':spades' and ':clubs'.

  """
  def battle_cards(%{:card_suit => suit_one, :card_value => value_one}, %{:card_suit => suit_two, :card_value => value_two}) do
    cond do
      value_one > value_two ->
        :cards_one_wins
      value_two > value_one ->
        :card_two_wins
      value_one === value_two ->
        case {suit_one, suit_two} do
          {:diamond, _} ->
            :cards_one_wins
          {_, :diamond} ->
            :cards_two_wins
          {:hearts, _} ->
            :cards_one_wins
          {_, :hearts} ->
            :cards_two_wins
          {:spades, _} ->
            :cards_one_wins
          {_, :spades} ->
            :cards_two_wins
          {:clubs, _} ->
            :cards_one_wins
          {_, :clubs} ->
            :cards_two_wins
        end
    end
  end

end

# BATTLE TWO CARDS

# deck = Cards.create_deck
# deck = Cards.shuffle deck
# {[card_one], deck} = Cards.deal deck
# {[card_two], deck} = Cards.deal deck
# card_one
# card_two
# Cards.battle_cards card_one, card_two

# DEAL 2 HOLD'EM HANDS

# deck = Cards.create_deck
# deck = Cards.shuffle deck
# {hand_one, deck} = Cards.deal deck, 2
# {hand_two, deck} = Cards.deal deck, 2
# hand_one
# hand_two
