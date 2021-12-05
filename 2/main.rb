require 'pattern-match'

input = IO.readlines('./input.txt', chomp: true)

using PatternMatch

horizontal = 0
depth = 0

input.each do |line|
  match(line.split(' ')) do
    with(_['forward', count]) { horizontal += count.to_i }
    with(_['down', count]) { depth += count.to_i }
    with(_['up', count]) { depth -= count.to_i }
  end
end

p "Horizontal - #{horizontal}"
p "Depth - #{depth}"
p "Score - #{depth * horizontal}"
