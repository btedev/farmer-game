defmodule FarmerGameTest do
  use ExUnit.Case
  import FarmerGame

  test "it parses initial string"  do
    assert parse("fdcg~") == {"fdcg", ""}
    assert parse("fd~cg") == {"fd", "cg"}
    assert parse("~fdcg") == {"", "fdcg"}
  end

  test "it moves right" do
    post_state = "fdcg~"
               |> parse
               |> move("fc>")

    assert post_state == {"dg", "fc"}
  end

  test "it moves left" do
    post_state = "g~fdc"
               |> parse
               |> move("<fd")

    assert post_state == {"gfd", "c"}
  end

  test "sample 1" do
    input = "fdcg~ fc> <f fd>" |> String.split(" ")
    result = play(input)
    assert result == {:ok, "g~fcd"}
  end

  test "sample 2" do
    input = "fdcg~ fc> <f fg> <f" |> String.split(" ")
    result = play(input)
    assert result == {:eaten, "fd~cg"}
  end

  test "winning moves" do
    input = "fdcg~ fc> <f fg> <fc fd> <f fc>" |> String.split(" ")
    result = play(input)
    assert result == {:ok, "~fgdc"}
  end
end
