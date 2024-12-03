defmodule Day03 do
  def part1(data) do
    ~r/mul\(\d+,\d+\)/
    |> Regex.scan(data)
    |> Enum.map(fn [str] ->
      Regex.named_captures(~r/mul\((?<a>\d+),(?<b>\d+)\)/, str)
    end)
    |> extract_and_multiply()
    |> Enum.reduce(fn num, acc -> num + acc end)
  end

  def part2(data) do
    ~r/mul\(\d+,\d+\)|do\(\)|don't\(\)/
    |> Regex.scan(data)
    |> Enum.reduce({true, []}, fn operation, {enable, ops} ->
      case operation do
        ["do()"] ->
          {true, ops}

        ["don't()"] ->
          {false, ops}

        [mul] ->
          if enable do
            res = Regex.named_captures(~r/mul\((?<a>\d+),(?<b>\d+)\)/, mul)
            {enable, ops ++ [res]}
          else
            {enable, ops}
          end
      end
    end)
    |> elem(1)
    |> extract_and_multiply()
    |> Enum.reduce(fn num, acc -> num + acc end)
  end

  defp extract_and_multiply(data) do
    Enum.map(data, fn %{"a" => a_str, "b" => b_str} ->
      {a, ""} = Integer.parse(a_str)
      {b, ""} = Integer.parse(b_str)
      a * b
    end)
  end
end
