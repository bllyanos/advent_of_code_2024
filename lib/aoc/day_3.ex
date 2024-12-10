defmodule AOC.Day3 do
  alias AOC.Day3.ToggleParser
  alias AOC.Day3.Parser

  def run(path) do
    graphemes =
      load_script(path)
      |> String.graphemes()

    graphemes
    |> Parser.parse([], :any, 0)
    |> IO.inspect(label: "result")

    ToggleParser.default_config()
    |> ToggleParser.parse(ToggleParser.default_context(graphemes))
    |> IO.inspect(label: "result_toggle")
  end

  def load_script(path) do
    File.read!(path)
  end
end
