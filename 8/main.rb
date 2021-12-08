# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)
# input = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"]

def s(string)
  string.chars.sort.join
end

rows = input.map do |line|
  signal, output = line.split('|').map(&:split)

  c1 = s signal.find { _1.length == 2 }
  c4 = s signal.find { _1.length == 4 }
  c7 = s signal.find { _1.length == 3 }
  c8 = s signal.find { _1.length == 7 }

  c235 = signal.filter { _1.length == 5 }

  c3 = s c235.find {
    _1.chars.intersection(c7.chars).length == 3
  }

  c25 = c235.reject { s(_1) == c3 }

  bl = (c8.chars - c3.chars - c4.chars).first

  c2, c5 = c25.partition { _1.chars.include? bl }
  c2 = s c2.first
  c5 = s c5.first

  c9 = (c8.chars - [bl]).sort.join

  c06 = signal.filter { _1.length == 6 && s(_1) != c9 }
  c6, c0 = c06.partition { (_1.chars - c5.chars).length == 1 }
  c6 = s c6.first
  c0 = s c0.first

  chars = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9]
  # pp "With #{chars.uniq.inspect}"

  output.map do |num|
    chars.find_index(s(num))
  end.join.to_i
end

pp rows.sum
