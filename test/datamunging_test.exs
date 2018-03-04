defmodule Elixirkata.DataMungingTest do
  use ExUnit.Case
  alias Elixirkata.DataMunging, as: DataMunging
  doctest Elixirkata.DataMunging

  test "parseWeather" do
    assert 9 == DataMunging.parseWeather("../weather.dat")
  end

  test "parseFootball" do
    assert "Aston_Villa" == DataMunging.parseFootball("../football.dat")
  end
end
