defmodule AOC.Day2 do
  alias AOC.Day2.Generator
  import AOC.Common

  def run(input_path) do
    reports = input_path |> load_reports()

    reports
    |> Enum.map(&analyze_list/1)
    |> sum_safe_report()
    |> IO.inspect(label: "first run result, safe reports")

    reports
    |> run_dampener()
    |> sum_safe_report()
    |> IO.inspect(label: "second run result, safe reports")
  end

  def run_dampener(reports) do
    Enum.map(reports, fn numbers ->
      case analyze_list(numbers) do
        :safe ->
          :safe

        :unsafe ->
          count = Enum.count(numbers)
          run_dampener_generator(numbers, count, count)
      end
    end)
  end

  def run_dampener_generator(_reports, _count, 0) do
    :unsafe
  end

  def run_dampener_generator(reports, count, reverse_at) do
    at = count - reverse_at
    {:ok, new_reports} = Generator.drop_at(reports, at)

    case analyze_list(new_reports) do
      :safe -> :safe
      :unsafe -> run_dampener_generator(reports, count, reverse_at - 1)
    end
  end

  defp sum_safe_report(reports, num \\ 0) do
    case reports do
      [:safe | more] -> sum_safe_report(more, num + 1)
      [:unsafe | more] -> sum_safe_report(more, num)
      [] -> num
    end
  end

  # load the reports from file
  defp load_reports(input_path) do
    File.read!(input_path)
    |> split_by_newline()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> split_by_space()
    |> cast_all_to_integer()
  end

  def analyze_list(numbers, indicator \\ :unknown)

  # analyze first element
  def analyze_list([number | [next | more]], :unknown) do
    case diff(number, next) do
      :same -> :unsafe
      {_, false} -> :unsafe
      {indicator, true} -> analyze_list([next | more], indicator)
    end
  end

  # analyze second and the rest elements
  def analyze_list([number | [next | more]], indicator) do
    case diff(number, next) do
      # the value is same, return :unsafe
      :same -> :unsafe
      # the value is either increasing or decreasing with safe value, continue iteration
      {^indicator, true} -> analyze_list([next | more], indicator)
      # default case, :unsafe
      {_, _} -> :unsafe
    end
  end

  def analyze_list([_number | []], _indicator), do: :safe
  def analyze_list(_, _), do: :unsafe

  # determine if the diff is increasing/decreasing and safe difference
  defp diff(left, right, safe_max \\ 3) do
    diff = left - right

    cond do
      diff == 0 -> :same
      diff > 0 -> {:decrease, abs(diff) <= safe_max}
      diff < 0 -> {:increase, abs(diff) <= safe_max}
    end
  end
end
