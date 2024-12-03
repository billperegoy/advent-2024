defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  describe "part 1" do
    test "small data set" do
      assert small_data_set() |> Day03.part1() == 161
    end

    test "large data set" do
      assert large_data_set() |> Day03.part1() == 173_529_487
    end
  end

  describe "part 2" do
    test "small data set" do
      assert small_data_set2() |> Day03.part2() == 48
    end

    test "large data set" do
      assert large_data_set() |> Day03.part2() == 99_532_691
    end
  end

  defp small_data_set do
    """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """
  end

  defp small_data_set2 do
    """
    xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    """
  end

  defp large_data_set do
    {:ok, text} = File.read("test/large_file.txt")
    text
  end
end
