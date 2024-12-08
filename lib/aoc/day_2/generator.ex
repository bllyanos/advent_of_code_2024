defmodule AOC.Day2.Generator do
  @larger_error "at out of bonds"
  @negative_number "at cannot be negative"

  def drop_at(list, at) do
    IO.inspect({list, at}, charlists: :as_list)
    count = Enum.count(list)

    cond do
      at >= count -> {:error, @larger_error}
      at < 0 -> {:error, @negative_number}
      true -> iterate_drop(list, at)
    end
  end

  defp iterate_drop([num | more], at, current \\ 0, removed \\ []) do
    cond do
      current == at -> {:ok, Enum.reverse(removed) ++ more}
      true -> iterate_drop(more, at, current + 1, [num | removed])
    end
  end
end
