defmodule Elixirkata.KarateChop do
  @moduledoc"""
  http://codekata.com/kata/kata02-karate-chop/
  """

  defp chop1(_, [], _), do: -1
  defp chop1(target, [head | _], index) when target == head, do: index
  defp chop1(target, [head | tail], index) when target != head do
    chop1(target, tail, index + 1)
  end

  # First implementation
  def chop1(target, list) do
    chop1(target, list, 0)
  end

  defp extractIndex({_, index}), do: index
  defp extractIndex(-1), do: -1
  # Second implementation
  def chop2(target, list) do
    list |> Enum.with_index
    |> Enum.find(-1, fn {value, _} -> target == value end)
    |> extractIndex
  end
end
