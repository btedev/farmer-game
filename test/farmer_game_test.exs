defmodule FarmerGameTest do
  use ExUnit.Case
  import FarmerGame

  test "it parses initial string"  do
    assert parse("fdcg~") == {"fdcg", ""}
    assert parse("fd~cg") == {"fd", "cg"}
    assert parse("~fdcg") == {"", "fdcg"}
  end

  test "it moves left" do
    post_state = "fdcg~"
               |> parse
               |> move("fc>")

    assert post_state == {"dg", "cf"}
  end

  test "it moves right" do
    post_state = "g~fdc"
               |> parse
               |> move("<fd")

    assert post_state == {"dfg", "c"}
  end

  test "sample 1" do
    input = "fdcg~ fc> <f fd>" |> String.split(" ")
    result = play(input)
    assert result == {:ok, "g~cdf"}
  end

  test "sample 2" do
    input = "fdcg~ fc> <f fg> <f" |> String.split(" ")
    result = play(input)
    assert result = {:eaten, "df~cg"}
  end
end
