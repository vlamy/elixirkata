defmodule ElixirkataTest do
  use ExUnit.Case
  doctest Elixirkata

  test "greets the world" do
    assert Elixirkata.hello() == :world
  end
end
