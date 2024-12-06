defmodule AOC.Common do
  def split_by_newline(text), do: String.split(text, "\n")
  def split_by_space(text), do: String.split(text, " ")

  def cast_all_to_integer(elements, acc \\ [])
  def cast_all_to_integer([], acc), do: Enum.reverse(acc)

  def cast_all_to_integer(["" | more], acc) do
    cast_all_to_integer(more, acc)
  end

  def cast_all_to_integer([element | more], acc) do
    parsed = String.to_integer(element)
    cast_all_to_integer(more, [parsed | acc])
  end
end
