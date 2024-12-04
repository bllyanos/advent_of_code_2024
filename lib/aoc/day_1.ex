defmodule AOC.Day1 do
  alias AOC.Day1.Similarity
  alias AOC.Day1.InputCleaner
  alias AOC.Day1.Distance

  def run(input_path) do
    # clean input
    pairs = get_pairs(input_path)

    # first challenge
    Distance.calculate_pairs(pairs) |> IO.inspect(label: "first result")

    # second challenge
    pairs
    |> InputCleaner.unzip()
    |> Similarity.get_score()
    |> IO.inspect(label: "second result")
  end

  defp get_pairs(path) do
    path
    |> read_file()
    |> InputCleaner.cleanup_input()
  end

  defp read_file(input_path), do: File.read!(input_path)
end
