# Run it with: elixir day_2/part_1.exs
#
# To solve with given dataset, run:
# $ iex day_2/part_1.exs
# iex(1)> Part1.solve("day_2/data.txt")
#
# https://adventofcode.com/2018/day/1
defmodule Part1 do
  def solve(box_ids) when is_binary(box_ids) do
    unless File.exists?(box_ids), do: raise("File not found")

    File.stream!(box_ids)
    |> Stream.map(&String.trim(&1))
    |> solve()
  end

  def solve(box_ids) do
    box_ids
    |> Enum.reduce({0, 0}, fn box_id, {count2, count3} ->
      histogram = histogram(box_id)
      {count2 + has_count2?(histogram), count3 + has_count3?(histogram)}
    end)
    |> checksum()
  end

  defp histogram(box_id) do
    box_id
    |> String.codepoints()
    |> Enum.reduce(%{}, fn letter, acc ->
      letter_count = Map.get(acc, letter, 0)
      Map.put(acc, letter, letter_count + 1)
    end)
  end

  defp has_count2?(histogram) do
    if Enum.any?(histogram, fn {_, value} -> value == 2 end), do: 1, else: 0
  end

  defp has_count3?(histogram) do
    if Enum.any?(histogram, fn {_, value} -> value == 3 end), do: 1, else: 0
  end

  defp checksum({count2, count3}), do: count2 * count3
end

ExUnit.start()

defmodule Part1Test do
  use ExUnit.Case

  import Part1

  test "provided test cases" do
    assert solve(["abcdef"]) == 0
    assert solve(["bababc"]) == 1
    assert solve(["abbcde"]) == 0
    assert solve(["abcccd"]) == 0
    assert solve(["aabcdd"]) == 0
    assert solve(["abcdee"]) == 0
    assert solve(["ababab"]) == 0
    assert solve([
      "abcdef",
      "bababc",
      "abbcde",
      "abcccd",
      "aabcdd",
      "abcdee",
      "ababab"
    ]) == 12
  end
end
