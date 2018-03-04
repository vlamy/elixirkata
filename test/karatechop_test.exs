defmodule Elixirkata.KarateChopTest do
  use ExUnit.Case
  alias Elixirkata.KarateChop, as: KarateChop
  doctest Elixirkata.KarateChop

  def assertChop(chop) do
    assert -1 == chop.(3, [])
    assert -1 == chop.(3, [1])
    assert 0 == chop.(1, [1])

    assert 0 == chop.(1, [1, 3, 5])
    assert 1 == chop.(3, [1, 3, 5])
    assert 2 == chop.(5, [1, 3, 5])
    assert -1 == chop.(0, [1, 3, 5])
    assert -1 == chop.(2, [1, 3, 5])
    assert -1 == chop.(4, [1, 3, 5])
    assert -1 == chop.(6, [1, 3, 5])

    assert 0 == chop.(1, [1, 3, 5, 7])
    assert 1 == chop.(3, [1, 3, 5, 7])
    assert 2 == chop.(5, [1, 3, 5, 7])
    assert 3 == chop.(7, [1, 3, 5, 7])
    assert -1 == chop.(0, [1, 3, 5, 7])
    assert -1 == chop.(2, [1, 3, 5, 7])
    assert -1 == chop.(4, [1, 3, 5, 7])
    assert -1 == chop.(6, [1, 3, 5, 7])
    assert -1 == chop.(8, [1, 3, 5, 7])
  end

  test "chop1" do
    assertChop(&KarateChop.chop1/2)
  end

  test "chop2" do
    assertChop(&KarateChop.chop2/2)
  end
end
