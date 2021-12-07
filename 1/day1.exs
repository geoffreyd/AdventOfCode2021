defmodule AdventOfCodeDay1 do
  def part1(:sample), do: File.stream!("./sample.txt") |> process1;
  def part1(:actual), do: File.stream!("input.txt") |> process1;

  def process1(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce({10000, 0}, fn (x, {prev, count}) ->
      inc = if (x > prev), do: count + 1, else: count
      {x,  inc}
    end)
    |> elem(1)
  end

  def part2(:sample), do: File.stream!("./sample.txt") |> process2;
  def part2(:actual), do: File.stream!("input.txt") |> process2;

  def process2(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(3, 1)
    |> Enum.reduce({[9000,9000,9000], 0}, fn (current, {prev, count}) ->
      curr = Enum.sum(current)
      inc = if (curr > prev), do: count + 1, else: count
      {curr, inc}
    end)
    |> elem(1)
  end
end

# ExUnit.configure(exclude: :skip)
ExUnit.start()

defmodule AdventOfCodeDay1Test do
  use ExUnit.Case

  @tag :skip
  test "does the thing with sample data" do
    assert AdventOfCodeDay1.part1(:sample) == 7
  end

  @tag :skip
  test "does the thing with real data" do
    assert AdventOfCodeDay1.part1(:actual) == 1393
  end

  test "part 2 works with sample data" do
    assert AdventOfCodeDay1.part2(:sample) == 5
  end

  test "part 2 works with real data" do
    assert AdventOfCodeDay1.part2(:actual) == 1359
  end
end
