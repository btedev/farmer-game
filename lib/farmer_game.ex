defmodule FarmerGame do
  @moduledoc """
  Solution for Farmer challenge.
  """

  def parse(state_string) do
    String.split(state_string, "~") |> List.to_tuple
  end

  # Given a list of input strings,
  # play the game until input ends
  # or a move results in :eaten.
  def play([h|t]) do
    init_state = parse(h)
    play(init_state, t)
  end

  # End states with illegal moves.
  def play(state={"cd", _}, _), do: {:eaten, formatted_state(state)}
  def play(state={"dc", _}, _), do: {:eaten, formatted_state(state)}
  def play(state={_, "cd"}, _), do: {:eaten, formatted_state(state)}
  def play(state={_, "dc"}, _), do: {:eaten, formatted_state(state)}
  def play(state={"cg", _}, _), do: {:eaten, formatted_state(state)}
  def play(state={"gc", _}, _), do: {:eaten, formatted_state(state)}
  def play(state={_, "cg"}, _), do: {:eaten, formatted_state(state)}
  def play(state={_, "gc"}, _), do: {:eaten, formatted_state(state)}

  # End state without illegal moves.
  def play(state, []),  do: {:ok, formatted_state(state)}

  def play(state, [movement|t]) do
    new_state = move(state, movement)
    play(new_state, t)
  end

  def formatted_state({left, right}) do
    f_first(left) <> "~" <> f_first(right)
  end

  # Output always order the farmer first.
  def f_first(string) do
    case String.contains?(string, "f") do
      true ->
        "f" <> String.replace(string, "f", "")
      false ->
        string
    end
  end

  # Perform move for all other movements.
  def move(game_state, movement) do
    cond do
      String.last(movement) == ">" ->
        String.split(movement, ">")
        |> Enum.at(0)
        |> String.graphemes
        |> move_right(game_state)

      String.first(movement) == "<" ->
        String.split(movement, "<")
        |> Enum.at(1)
        |> String.graphemes
        |> move_left(game_state)

      true ->
        raise "Illegal move: #{movement}"
    end
  end

  def move_right(graphemes, {left_bank, right_bank}) do
    graphemes
    |> Enum.reduce({left_bank, right_bank}, fn(g, {left, right}) ->
      new_left = remove_char(left, g)
      new_right = add_char(right, g)
      {new_left, new_right}
    end)
  end

  def move_left(graphemes, {left_bank, right_bank}) do
    graphemes
    |> Enum.reduce({left_bank, right_bank}, fn(g, {left, right}) ->
      new_left = add_char(left, g)
      new_right = remove_char(right, g)
      {new_left, new_right}
    end)
  end

  def remove_char(string, char), do: String.replace(string, char, "")

  def add_char(string, char), do: string <> char

  def sort_string(s) do
    String.graphemes(s)
    |> Enum.sort
    |> Enum.join
  end
end

