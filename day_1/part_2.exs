# Run it with: elixir day_1/part_2.exs
#
# To solve with given dataset, run:
# $ iex day_1/part_2.exs
# iex(1)> Part2.solve("day_1/data.txt")
#
# https://adventofcode.com/2018/day/1
defmodule Part2 do
  def solve(changes) when is_binary(changes) do
    unless File.exists?(changes), do: raise("File not found")

    File.stream!(changes)
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.to_integer(&1))
    |> solve()
  end

  def solve(changes) do
    changes
    |> Stream.cycle()
    |> Enum.reduce_while([0], fn change, acc ->
      [last | _] = acc
      next = last + change
      if Enum.member?(acc, next), do: {:halt, next}, else: {:cont, [next | acc]}
    end)
  end
end

ExUnit.start()

defmodule Part2Test do
  use ExUnit.Case

  import Part2

  test "provided test cases" do
    assert solve([1, -2, 3, 1, 1, -2]) == 2
    assert solve([1, -1]) == 0
    assert solve([3, 3, 4, -2, -4]) == 10
    assert solve([-6, 3, 8, 5, -6]) == 5
    assert solve([7, 7, -2, -7, -4]) == 14
  end
end
