defmodule AOC.Day2.GeneratorTest do
  alias AOC.Day2.Generator
  use ExUnit.Case

  test "drop at" do
    list = [1, 2, 3, 4, 5]
    {:ok, nums} = Generator.drop_at(list, 0)
    assert nums == [2, 3, 4, 5]
  end
end
