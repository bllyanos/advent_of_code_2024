defmodule AOC.Day3 do
  def run(path) do
    load_script(path)
    |> String.graphemes()
    |> parse([], :any, 0)
    |> IO.inspect(label: "result")
  end

  def load_script(path) do
    File.read!(path)
  end

  def parse(graphemes, stack, expectation, store)

  def parse(["m" | ["u" | ["l" | ["(" | rest]]]], _, :any, store) do
    parse(rest, [], {:num, :comma}, store)
  end

  def parse([")" | rest], stack, {:num, :close}, store) do
    [left, right] = Enum.reverse(stack) |> Enum.join("") |> String.split(",")
    result = String.to_integer(left) * String.to_integer(right)
    parse(rest, [], :any, store + result)
  end

  def parse(["," | rest], stack, {:num, :comma}, store) do
    parse(rest, ["," | stack], {:num, :close}, store)
  end

  def parse([num | rest], stack, {:num, :comma}, store) do
    case String.match?(num, ~r/^\d+$/) do
      true -> parse(rest, [String.to_integer(num) | stack], {:num, :comma}, store)
      false -> parse(rest, [], :any, store)
    end
  end

  def parse([num | rest], stack, {:num, :close}, store) do
    case String.match?(num, ~r/^\d+$/) do
      true -> parse(rest, [String.to_integer(num) | stack], {:num, :close}, store)
      false -> parse(rest, [], :any, store)
    end
  end

  def parse([_ | next], _stack, :any, store) do
    parse(next, [], :any, store)
  end

  def parse(_, _, _, store) do
    store
  end
end
