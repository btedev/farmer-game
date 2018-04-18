defmodule FarmerGame.CLI do

  def main(args \\ []) do
    filename =    args
                  |> parse_args

    input = File.read!(filename)
            |> String.trim
            |> String.replace("\n", " ")

    {result, output} = input
                       |> String.split(" ")
                       |> FarmerGame.play

    IO.puts(output)

    if result == :eaten do
      {left, right} = String.split(output, "~") |> List.to_tuple

      msg = case {left, right} do
        {_, "cg"} -> "Grain was eaten"
        {"cg", _} -> "Grain was eaten"
        {_, "gc"} -> "Grain was eaten"
        {"gc", _} -> "Grain was eaten"
        {_, "cd"} -> "Chicken was eaten"
        {"cd", _} -> "Chicken was eaten"
        {_, "dc"} -> "Chicken was eaten"
        {"dc", _} -> "Chicken was eaten"
      end

      IO.puts(msg)
    end
  end

  defp parse_args(args) do
    {_, words, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean])

    Enum.at(words, 0)
  end
end
