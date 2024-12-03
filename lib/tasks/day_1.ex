defmodule Mix.Tasks.Day1 do
  alias AOC.Day1
  use Mix.Task

  def run([path]) do
    Day1.run(path)
  end
end
