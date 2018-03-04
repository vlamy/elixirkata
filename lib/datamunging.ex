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

  defp formatAndConvert(filepath, format, convert) do
    filepath
    |> decodeDat
    |> Enum.map(format)
    |> Enum.reject(fn x -> x == :rejected end)
    |> Enum.map(convert)
  end

  def parseWeather(filepath) do
    filepath
    |> formatAndConvert(&formatEntries/1, &computeSpread/1)
    |> Enum.max_by(fn {_, mxt} -> mxt end)
    |> elem(0)
  end

  defp formatFootEntries(entry) do
    case entry do
      [_, team, _, _, _, _ , for_v, _ , against, _] -> {team, for_v, against}
      _ -> :rejected
    end
  end

  defp convertFootEntrie({team, for_v, against}) do
    {team, abs(convertEntry(for_v) - convertEntry(against))}
    rescue
      _ -> :rejected
  end

  def parseFootball(filepath) do
    filepath
    |> formatAndConvert(&formatFootEntries/1, &convertFootEntrie/1)
    |> Enum.min_by(fn {_, diff} -> diff end)
    |> elem(0)
  end
end
