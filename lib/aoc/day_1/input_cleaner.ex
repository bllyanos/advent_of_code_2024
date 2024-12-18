defmodule AOC.Day1.InputCleaner do
  def cleanup_input(content) do
    content
    |> String.split("\n")
    |> lines_to_num_pair()
    |> sort_pairs()
  end

  def unzip(pairs) do
    [{[], []} | pairs]
    |> Enum.reduce(&group_reducer/2)
  end

  defp lines_to_num_pair(lines) do
    lines
    |> Enum.map(fn line -> String.split(line, "   ") end)
    |> parse_pairs_to_integer()
  end

  defp parse_pairs_to_integer(pairs) do
    [[] | pairs]
    |> Enum.reduce(&parse_reducer/2)
  end

  # return tuple of integers (left and right)
  defp parse_reducer([left, right], acc) do
    left_integer = String.to_integer(left)
    right_integer = String.to_integer(right)
    [{left_integer, right_integer} | acc]
  end

  # return acc directly if the pair is wildcard
  defp parse_reducer(_, acc), do: acc

  defp sort_pairs(pairs) do
    unzip(pairs)
    |> sort_grouped_pairs()
  end

  defp group_reducer({left, right}, {left_acc, right_acc}) do
    left_result = [left | left_acc]
    right_result = [right | right_acc]
    {left_result, right_result}
  end

  defp sort_grouped_pairs({left, right}) do
    sorted_left = Enum.sort(left)
    sorted_right = Enum.sort(right)

    [sorted_left, sorted_right]
    |> Enum.zip()
  end
end
