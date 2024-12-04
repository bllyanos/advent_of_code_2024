defmodule AOC.Day1.Similarity do
  def get_score({left_list, right_list} = _pairs) do
    occurences = calculate_occurences(%{}, right_list)
    left_list |> sum_score(occurences, 0)
  end

  defp sum_score([entry | more], occur, acc) do
    case Map.fetch(occur, entry) do
      {:ok, occurence} -> sum_score(more, occur, acc + entry * occurence)
      :error -> sum_score(more, occur, acc)
    end
  end

  defp sum_score([], _, acc), do: acc

  defp calculate_occurences(%{} = acc, [entry | more]) do
    case Map.fetch(acc, entry) do
      {:ok, current} -> Map.put(acc, entry, current + 1)
      :error -> Map.put(acc, entry, 1)
    end
    |> calculate_occurences(more)
  end

  defp calculate_occurences(%{} = acc, []), do: acc
end
