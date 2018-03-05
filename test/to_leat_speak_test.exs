defmodule Elixirkata.ToLeetSpeakTest do
  use ExUnit.Case
  alias Elixirkata.ToLeetSpeak, as: ToLeetSpeak

  test "Basic tests" do
    assert ToLeetSpeak.translate("LEET") == "1337"
    assert ToLeetSpeak.translate("CODEWARS") == "(0D3W@R$"
    assert ToLeetSpeak.translate("HELLO WORLD") == "#3110 W0R1D"
    assert ToLeetSpeak.translate("LOREM IPSUM DOLOR SIT AMET") == "10R3M !P$UM D010R $!7 @M37"
    assert ToLeetSpeak.translate("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG") == "7#3 QU!(K 8R0WN F0X JUMP$ 0V3R 7#3 1@2Y D06"
  end
end
