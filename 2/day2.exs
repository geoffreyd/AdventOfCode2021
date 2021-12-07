
defmodule AdventOfCodeDay2 do
  import String, only: [to_integer: 1]

  def part1(:sample), do: File.stream!("sample.txt") |> process1;
  def part1(:actual), do: File.stream!("input.txt") |> process1;

  def process1(stream) do
    stream
    |> prep()
    |> Enum.reduce({0,0}, &AdventOfCodeDay2.instruction/2 )
    |> Tuple.product()
  end

  def instruction(["forward", count], {p, d}), do: {p + to_integer(count), d};
  def instruction(["down", count], {p, d}), do: {p, d + to_integer(count)};
  def instruction(["up", count], {p, d}), do: {p, d - to_integer(count)};


  def part2(:sample), do: File.stream!("sample.txt") |> process2;
  def part2(:actual), do: File.stream!("input.txt") |> process2;

  def process2(stream) do
    stream
    |> prep()
    |> Enum.reduce({0,0,0}, &AdventOfCodeDay2.instruction2/2 )
    |> Tuple.delete_at(2)
    |> Tuple.product()
  end

  def instruction2(["forward", count], {p, d, a})  do
    c = to_integer(count)
    {p + c, (d + (c * a)), a}
  end
  def instruction2(["down", count], {p, d, a}), do: {p, d, a + to_integer(count)};
  def instruction2(["up", count], {p, d, a}), do: {p, d, a - to_integer(count)};

  def prep(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split/1)
  end
end

ExUnit.start()

defmodule AdventOfCodeDay2Test do
  use ExUnit.Case

  # @tag :skip
  test "part 1 works with sample data" do
    assert AdventOfCodeDay2.part1(:sample) == 150
  end

  # @tag :skip
  test "part 1 works with real data" do
    assert AdventOfCodeDay2.part1(:actual) == 1962940
  end

  # @tag :skip
  test "part 2 works with sample data" do
    assert AdventOfCodeDay2.part2(:sample) == 900
  end

  # @tag :skip
  test "part 2 works with real data" do
    assert AdventOfCodeDay2.part2(:actual) == 1813664422
  end
end
