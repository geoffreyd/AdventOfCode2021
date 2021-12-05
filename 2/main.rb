require 'pattern-match'
using PatternMatch

input = IO.readlines('./input.txt', chomp: true)

horizontal = 0
depth = 0
aim = 0

input.each do |line|
  direction, value = line.split
  match([direction, value.to_i]) do
    with(_['forward', count]) {
      horizontal += count
      depth += aim * count
    }
    with(_['down', count]) { aim += count }
    with(_['up', count]) { aim -= count }
  end
  p "Horizontal - #{horizontal}"
  p "Depth - #{depth}"
end

p "Score - #{depth * horizontal}"
