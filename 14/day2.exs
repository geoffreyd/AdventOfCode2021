defmodule AdventOfCodeDay do
  def part1(:sample), do: File.stream!("sample.txt") |> process1;
  def part1(:actual), do: File.stream!("input.txt") |> process1;

  def process1(stream) do

  end

  def part2(:sample), do: File.stream!("sample.txt") |> process2;
  def part2(:actual), do: File.stream!("input.txt") |> process2;

  def process2(stream) do

  end
end

ExUnit.start()

defmodule AdventOfCodeDayTest do
  use ExUnit.Case

  @tag :skip
  test "part 1 works with sample data" do
    assert AdventOfCodeDay.part1(:sample) == 7
  end

  @tag :skip
  test "part 2 works with real data" do
    assert AdventOfCodeDay.part1(:actual) == 1393
  end

  @tag :skip
  test "part 2 works with sample data" do
    assert AdventOfCodeDay.part2(:sample) == 5
  end

  @tag :skip
  test "part 2 works with real data" do
    assert AdventOfCodeDay.part2(:actual) == 1359
  end
end
