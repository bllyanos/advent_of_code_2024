defmodule Mix.Tasks.Day2 do
  alias AOC.Day2
  use Mix.Task

  def run([path]) do
    Day2.run(path)
  end
end
