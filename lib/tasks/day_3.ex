defmodule Mix.Tasks.Day3 do
  alias AOC.Day3
  use Mix.Task

  def run([path]) do
    Day3.run(path)
  end
end
