# Run it with: elixir day_2/part_2.exs
#
# To solve with given dataset, run:
# $ iex day_2/part_2.exs
# iex(1)> Part2.solve("day_2/data.txt")
#
# https://adventofcode.com/2018/day/2
defmodule Part2 do
  def solve(box_ids) when is_binary(box_ids) do
    unless File.exists?(box_ids), do: raise("File not found")

    File.stream!(box_ids)
    |> Stream.map(&String.trim(&1))
    |> Enum.to_list()
    |> solve()
  end

  def solve(box_ids) do
    box_ids
    |> pairs()
    |> Enum.filter(&(distance_between_words(&1) == 1))
    |> hd()
    |> common_letters()
  end

  def pairs([head | tail]) do
    for(x <- tail, do: {head, x}) ++ pairs(tail)
  end

  def pairs([]), do: []

  def distance_between_words({word1, word2}) do
    hamming_distance(String.codepoints(word1), String.codepoints(word2))
  end

  def hamming_distance(list1, list2, acc \\ 0)

  def hamming_distance([head1 | tail1], [head2 | tail2], acc) do
    acc = if head1 != head2, do: acc + 1, else: acc
    hamming_distance(tail1, tail2, acc)
  end

  def hamming_distance([], [], acc), do: acc

  defp common_letters({word1, word2}) do
    list1 = String.codepoints(word1)
    list2 = String.codepoints(word2)
    diff = list1 -- list2
    (list1 -- diff) |> Enum.join()
  end
end

ExUnit.start()

defmodule Part2Test do
  use ExUnit.Case

  import Part2

  test "provided test cases" do
    assert solve(~w[abcde fghij klmno pqrst fguij axcye wvxyz]) == "fgij"
  end
end
