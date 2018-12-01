# Run it with: elixir day_1/part_1.exs
#
# To solve with given dataset, run:
# $ iex day_1/part_1.exs
# iex(1)> Part1.solve("day_1/data.txt")
#
# https://adventofcode.com/2018/day/1
defmodule Part1 do
  def solve(freq_changes) when is_binary(freq_changes) do
    unless File.exists?(freq_changes), do: raise("File not found")

    File.stream!(freq_changes)
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.to_integer(&1))
    |> solve()
  end

  def solve(freq_changes) do
    Enum.sum(freq_changes)
  end
end

ExUnit.start()

defmodule Part1Test do
  use ExUnit.Case

  import Part1

  test "provided test cases" do
    assert solve([1, 1, 1]) == 3
    assert solve([1, 1, -2]) == 0
    assert solve([-1, -2, -3]) == -6
  end
end
