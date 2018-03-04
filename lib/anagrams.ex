defmodule Elixirkata.Anagrams do

  @moduledoc"""
  http://codekata.com/kata/kata06-anagrams/
  """

  def load_word_list(filepath) do
    filepath
    |> Path.expand(__DIR__)
    |> File.stream!
    |> Stream.map(&(String.replace(&1, "\n", "")))
  end

  defp hash(word) do
    String.to_charlist(word) |> Enum.sort
    rescue
      _ -> :not_utf8
  end

  defp insert_word_by_size(word, map) do
    hash = hash(word)
    case Map.fetch(map, hash) do
      :error -> Map.put(map, hash, [word])
      {:ok, list} -> Map.put(map, hash, Enum.concat(list, [word]))
    end
  end

  def run() do
    load_word_list("../wordlist.txt")
    |> Enum.reduce(%{}, &insert_word_by_size/2) #let operate by word size
    |> Map.values
    |> Enum.reject(fn l -> Enum.count(l) < 2 end)
    |> Enum.max_by(fn l -> String.length(Enum.at(l, 0)) end)
    # |> Enum.max_by(fn l -> Enum.count(l) end)
    # |> Enum.count
  end
end
