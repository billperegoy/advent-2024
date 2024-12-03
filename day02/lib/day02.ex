defmodule Day02 do
  def part_1(data) do
    data
    |> parse()
    |> Enum.map(&safe?/1)
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def part_2(data) do
    data
    |> parse()
    |> Enum.map(fn row ->
      dampended_reports(row)
    end)
    |> Enum.map(fn set ->
      Enum.any?(set, &safe?/1)
    end)
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  defp parse(data) do
    data
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn row ->
      Enum.map(row, fn str ->
        {num, ""} = Integer.parse(str)
        num
      end)
    end)
    |> Enum.reject(&Enum.empty?/1)
  end

  defp safe?(elems) do
    (increasing?(elems) || decreasing?(elems)) &&
      gradual?(elems)
  end

  defp increasing?(elems) do
    elems == Enum.sort(elems, :asc)
  end

  defp decreasing?(elems) do
    elems == Enum.sort(elems, :desc)
  end

  defp gradual?(elems) do
    Enum.reduce(elems, {nil, true}, fn elem, {previous_elem, state} ->
      case {previous_elem, state} do
        {nil, _state} -> {elem, state}
        {_previous, false} -> {elem, false}
        {previous, _state} -> {elem, abs(elem - previous) <= 3 && elem - previous != 0}
      end
    end)
    |> elem(1)
  end

  def dampended_reports(row) do
    length = Enum.count(row)
    indexes = Enum.to_list(0..(length - 1))

    Enum.reduce(indexes, [], fn index, acc ->
      acc ++ [List.delete_at(row, index)]
    end)
  end
end
