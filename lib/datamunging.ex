defmodule Elixirkata.DataMunging do
  @moduledoc"""
  http://codekata.com/kata/kata04-data-munging/
  """

  defp decodeDat(filepath) do
    filepath
    |> Path.expand(__DIR__)
    |> File.stream!
    |> Stream.map(&(String.replace(&1, "\n", "")))
    |> Enum.map(fn s -> String.split(s) end)
  end

  defp formatParsing(:error), do: raise "parsing error"
  defp formatParsing({int, _}), do: int

  defp convertEntry(entry) do
    entry
    |> String.replace("*", "")
    |> Integer.parse
    |> formatParsing
  end

  defp formatEntries([]), do: :rejected
  defp formatEntries([dy, mxt, mnt | _]) do
    {convertEntry(dy), convertEntry(mxt), convertEntry(mnt)}
    rescue
      _ -> :rejected
  end

  defp computeSpread({dy, mxt, mnt}), do: {dy, mxt - mnt}

  defp extractDy({dy, _}), do: dy

  def parseWeather(filepath) do
    filepath
    |> decodeDat
    |> Enum.map(&formatEntries/1)
    |> Enum.reject(fn x -> x == :rejected end)
    |> Enum.map(&computeSpread/1)
    |> Enum.max_by(fn {_, mxt} -> mxt end)
    |> extractDy
  end
end
