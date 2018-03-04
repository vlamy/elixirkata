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

  defp extractTeam({team, _}), do: team

  def parseFootball(filepath) do
    filepath
    |> decodeDat
    |> Enum.map(&formatFootEntries/1)
    |> Enum.reject(fn x -> x == :rejected end)
    |> Enum.map(&convertFootEntrie/1)
    |> Enum.min_by(fn {_, diff} -> diff end)
    |> extractTeam
  end
end
