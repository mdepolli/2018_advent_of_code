# Run it with: elixir day_1/exercise_1.exs
# https://adventofcode.com/2018/day/1
defmodule Exercise1 do
  def solve(freq_changes) when is_binary(freq_changes) do
    unless File.exists?(freq_changes), do: raise("File not found")

    File.read!(freq_changes)
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_integer(&1))
    |> solve()
  end

  def solve(freq_changes) when is_list(freq_changes) do
    Enum.sum(freq_changes)
  end
end

ExUnit.start()

defmodule Exercise1Test do
  use ExUnit.Case

  import Exercise1

  test "provided test cases" do
    assert solve([1, 1, 1]) == 3
    assert solve([1, 1, -2]) == 0
    assert solve([-1, -2, -3]) == -6
  end
end
