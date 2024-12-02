defmodule Day01 do
  def part_01(data) do
    {left_list, right_list} = extract_sorted_lists(data)

    left_list
    |> Enum.zip(right_list)
    |> Enum.map(fn {left, right} -> abs(right - left) end)
    |> Enum.reduce(fn val, acc -> acc + val end)
  end

  def part_02(data) do
    {left_list, right_list} = extract_sorted_lists(data)

    left_list
    |> Enum.zip(right_list)
    |> Enum.map(fn {left, _right} ->
      count_in_right =
        Enum.filter(right_list, &(&1 == left))
        |> Enum.count()

      count_in_right * left
    end)
    |> Enum.reduce(fn num, acc -> acc + num end)
  end

  defp extract_sorted_lists(data) do
    two_lists =
      data
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.reject(&Enum.empty?/1)

    left_list =
      Enum.map(two_lists, &Enum.at(&1, 0))
      |> Enum.map(fn str ->
        {num, ""} = Integer.parse(str)
        num
      end)
      |> Enum.sort()

    right_list =
      Enum.map(two_lists, &Enum.at(&1, 1))
      |> Enum.map(fn str ->
        {num, ""} = Integer.parse(str)
        num
      end)
      |> Enum.sort()

    {left_list, right_list}
  end
end
