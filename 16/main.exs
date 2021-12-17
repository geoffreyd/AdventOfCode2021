defmodule AdventOfCodeDay do
  def part1(:sample), do: File.read!("sample.txt") |> process1;
  def part1(:actual), do: File.read!("input.txt") |> process1;

  def process1(stream) do
    stream
    |> String.codepoints()
    |> Enum.map(&hex_to_binary/1)
    |> Enum.join("")
    # |> String.codepoints()
    # |> Enum.map(&String.to_integer/1)
    |> IO.inspect()
    |> parse_packet()
  end

  # convert a hex value
  def hex_to_binary(string) do
    string
    |> String.to_integer(16)
    |> Integer.digits(2)
    |> Integer.undigits()
    |> Integer.to_string()
    |> String.pad_leading(4, "0")
  end

  def read_binary(string) do
    # IO.inspect("reading: #{string}")
    String.to_integer(string, 2)
  end

  def parse_packet(content) do
    parse_packet(content, [], [], "")
  end
  # Literal Packet
  def parse_packet(<<version :: binary-size(3)>> <> "100" <> rest, outputs, versions, remainder) do
    IO.inspect("--Literal Packet--")
    IO.inspect("Version: #{read_binary(version)}")
    {result, tail} = rest
    |> decode_literal([])

    parse_packet(tail, outputs ++ [result], versions ++ [read_binary(version)], remainder)
  end
  # Operator Packet
  def parse_packet(<<version :: binary-size(3)>> <> <<_type :: binary-size(3)>> <> "0" <> <<len :: binary-size(15)>> <> rest, outputs, versions, remainder) do
    val_len = read_binary(len)
    IO.inspect("--Operator Packet - bit length -- #{val_len}")
    IO.inspect("Version: #{read_binary(version)}")
    <<sub_packets :: binary-size(val_len)>> <> after_packet = rest
    # IO.inspect(sub_packets)
    parse_packet(sub_packets, outputs, versions ++ [read_binary(version)], after_packet) #+ parse_packet(after_packet, outputs, versions, remainder)
  end
  def parse_packet(<<version :: binary-size(3)>> <> <<_type :: binary-size(3)>> <> "1" <> <<len :: binary-size(11)>> <> rest, outputs, versions, remainder) do
    val_len = read_binary(len)
    IO.inspect("--Operator Packet - packet count -- #{val_len}")
    IO.inspect("Version: #{read_binary(version)}")
    parse_packet(rest, outputs, versions ++ [read_binary(version)], remainder)
  end
  def parse_packet(_, outputs, versions, remainder) do
    IO.inspect("-- Found More -- #{remainder}")
    if String.length(remainder) == 0 do
      parse_packet("", outputs, versions)
    else
      parse_packet(remainder, outputs, versions, "")
    end
  end
  def parse_packet(_, outputs, versions) do
    IO.inspect("--No More - end --")
    # IO.inspect(outputs)
    IO.inspect("Versions! - #{versions}")
    IO.inspect(Enum.sum(versions))
    Enum.sum(versions)
  end

  def decode_literal("1" <> <<value :: binary-size(4)>> <> tail, collected) do
    IO.inspect("not last '#{value}'")
    decode_literal(tail, collected ++ [value])
  end
  def decode_literal("0" <> <<value :: binary-size(4)>> <> tail, collected) do
    IO.inspect("last '#{value}' - #{tail}")
    number = collected ++ [value]
    |> Enum.join("")
    |> read_binary()
    {number, tail}
  end
  def decode_literal(value, collected) do
    IO.inspect("Reached the end")
    collected
    |> Enum.map(&to_string/1)
    |> IO.inspect()
    {nil, value}
  end

  def decode_operator() do
    IO.inspect("--Operator Packet--")
  end

  # def part2(:sample), do: File.stream!("sample.txt") |> process2;
  # def part2(:actual), do: File.stream!("input.txt") |> process2;

  # def process2(stream) do

  # end
end

ExUnit.start()

defmodule AdventOfCodeDayTest do
  use ExUnit.Case

  @tag :skip
  test "part 1 works with literal packet" do
    assert AdventOfCodeDay.process1("D2FE28") == [2021]
  end

  @tag :skip
  test "part 1 works with 0101001000100100" do
    assert AdventOfCodeDay.parse_packet("0101001000100100") == [20]
  end

  @tag :skip
  test "part 1 works with 11010001010" do
    assert AdventOfCodeDay.parse_packet("11010001010") == [10]
  end

  @tag :skip
  test "part 1 works with 110100010100101001000100100" do
    assert AdventOfCodeDay.parse_packet("110100010100101001000100100") == [10,20]
  end

  @tag :skip
  test "part 1 works with 8A004A801A8002F478" do
    assert AdventOfCodeDay.process1("8A004A801A8002F478") == 16
  end

  @tag :skip
  test "part 1 works with C0015000016115A2E0802F182340" do
    assert AdventOfCodeDay.process1("C0015000016115A2E0802F182340") == 23
  end

  # @tag :skip
  test "part 1 works with EE00D40C823060" do
    assert AdventOfCodeDay.process1("EE00D40C823060") == 23
  end

  @tag :skip
  test "part 1 works with operator fixed length" do
    assert AdventOfCodeDay.process1("38006F45291200") == [10, 20]
  end

  @tag :skip
  test "part 1 works with real data" do
    assert AdventOfCodeDay.part1(:actual) == 996
  end

  @tag :skip
  test "part 2 works with sample data" do
    assert AdventOfCodeDay.part2(:sample) == 5
  end

  @tag :skip
  test "part 2 works with real data" do
    assert AdventOfCodeDay.part2(:actual) == 96257984154
  end
end
