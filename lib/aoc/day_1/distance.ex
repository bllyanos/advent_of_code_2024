defmodule AOC.Day1.Distance do
  @doc "match any list"
  def calculate_pairs([_ | _] = pairs) do
    Enum.map(pairs, &calculate_pair/1) |> Enum.sum()
  end

  defp calculate_pair({left, right}), do: abs(left - right)
end
