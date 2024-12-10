defmodule AOC.Day3.ToggleParser do
  def parse(config, context)

  def parse(%{toggle: :off} = config, context) do
    case check_off_toggle(context) do
      {:off, new_context} -> parse(config, new_context)
      {:on, new_context} -> parse(Map.put(config, :toggle, :on), new_context)
    end
  end

  def parse(%{toggle: :on} = config, context) do
    case check_on_toggle(context) do
      {:off, new_context} ->
        parse(Map.put(config, :toggle, :off), new_context)

      {:on, new_context} ->
        %{graphemes: g, stack: s, expectation: e, store: st} = new_context

        # IO.inspect(new_context.store, label: "store")

        parse_mul(g, s, e, st)
    end
  end

  def write_elements([], _), do: IO.puts("")
  def write_elements(_list, 0), do: IO.puts("")

  def write_elements([element | more], count) do
    IO.write(element <> " ")
    write_elements(more, count - 1)
  end

  def default_config, do: %{toggle: :on}

  def default_context(graphemes) do
    %{graphemes: graphemes, stack: [], expectation: :any, store: 0}
  end

  def check_off_toggle(context)

  def check_off_toggle(%{graphemes: ["d" | ["o" | ["(" | [")" | _more]]]]} = context) do
    new_context =
      empty_context_state(context)

    {:on, new_context}
  end

  def check_off_toggle(context) do
    {:off, pop_first_grapheme(context)}
  end

  def check_on_toggle(context)

  def check_on_toggle(
        %{
          graphemes: ["d" | ["o" | ["n" | ["'" | ["t" | ["(" | [")" | more]]]]]]]
        } = context
      ) do
    new_context =
      empty_context_state(context)
      |> Map.put(:graphemes, more)

    {:off, new_context}
  end

  def check_on_toggle(context) do
    {:on, pop_first_grapheme(context)}
  end

  def parse_mul(graphemes, stack, expectation, store)

  def parse_mul(["m" | ["u" | ["l" | ["(" | rest]]]], _, :any, store) do
    parse_mul(rest, [], {:num, :comma}, store)
  end

  def parse_mul([")" | rest], stack, {:num, :close}, store) do
    [left, right] = Enum.reverse(stack) |> Enum.join("") |> String.split(",")
    result = String.to_integer(left) * String.to_integer(right)
    IO.puts("#{left},#{right}")
    parse_mul(rest, [], :any, store + result)
  end

  def parse_mul(["," | rest], stack, {:num, :comma}, store) do
    parse_mul(rest, ["," | stack], {:num, :close}, store)
  end

  def parse_mul([num | rest], stack, {:num, :comma}, store) do
    case String.match?(num, ~r/^\d+$/) do
      true -> parse_mul(rest, [String.to_integer(num) | stack], {:num, :comma}, store)
      false -> parse_mul(rest, [], :any, store)
    end
  end

  def parse_mul([num | rest], stack, {:num, :close}, store) do
    case String.match?(num, ~r/^\d+$/) do
      true -> parse_mul(rest, [String.to_integer(num) | stack], {:num, :close}, store)
      false -> parse_mul(rest, [], :any, store)
    end
  end

  def parse_mul([_pop | _next] = graphemes, _stack, :any, store) do
    new_context =
      default_context(graphemes)
      |> empty_context_state()
      |> Map.put(:store, store)

    parse(default_config(), new_context)
  end

  def parse_mul(_, _, _, store) do
    store
  end

  defp pop_first_grapheme(%{graphemes: g} = context) do
    [_pop | more] = g

    context
    |> empty_context_state()
    |> Map.put(:graphemes, more)
  end

  defp empty_context_state(context) do
    context
    |> Map.put(:stack, [])
    |> Map.put(:expectation, :any)
  end
end
