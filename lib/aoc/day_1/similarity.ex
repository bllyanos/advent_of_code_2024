defmodule AOC.Day1.Similarity do
  # get the score of left list and right list
  def get_score({left_list, right_list} = _pairs) do
    occurences = calculate_occurences(%{}, right_list)
    left_list |> sum_score(occurences, 0)
  end

  # calculate how many times each number from the left list appears in the right list.
  defp calculate_occurences(%{} = acc, [entry | more]) do
    case Map.fetch(acc, entry) do
      {:ok, current} -> Map.put(acc, entry, current + 1)
      :error -> Map.put(acc, entry, 1)
    end
    |> calculate_occurences(more)
  end

  # return the acc if no more entry
  defp calculate_occurences(%{} = acc, []), do: acc

  # the score is determined by how many times each item in the first list appears in the second list, multiplied by itself.
  defp sum_score([entry | more], occur, acc) do
    case Map.fetch(occur, entry) do
      {:ok, occurence} -> sum_score(more, occur, acc + entry * occurence)
      :error -> sum_score(more, occur, acc)
    end
  end

  # return the acc if no more entry
  defp sum_score([], _, acc), do: acc
end
