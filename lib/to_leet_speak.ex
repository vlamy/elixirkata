defmodule Elixirkata.ToLeetSpeak do
  @moduledoc"""
  From codewars kata
  """

  @leet_dictionnary %{"A" => "@", "B" => "8", "C" => "(", "D" => "D", "E" => "3",
  "F" => "F", "G" => "6", "H" => "#", "I" => "!", "J" => "J", "K" => "K", "L" => "1",
  "M" => "M", "N" => "N", "O" => "0", "P" => "P", "Q" => "Q", "R" => "R", "S" => "$",
  "T" => "7", "U" => "U", "V" => "V", "W" => "W", "X" => "X", "Y" => "Y", "Z" => "2", " " => " "}

  def translate(str) do
    str
    |> String.codepoints
    |> Enum.map(fn c -> Map.fetch!(@leet_dictionnary, c) end)
    |> to_string
  end
end
