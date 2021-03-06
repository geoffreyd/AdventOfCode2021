# frozen_string_literal: true

input = IO.readlines('./sample.txt', chomp: true)

horizontal = 0
depth = 0
aim = 0

input.each do |line|
  direction, value = line.split

  case [direction, value.to_i]
  in 'forward', count
    horizontal += count
    depth += aim * count

  in 'down', count
    aim += count

  in 'up', count
    aim -= count

  else
    raise 'unknown instruction'
  end

  # p "Horizontal - #{horizontal}"
  # p "Depth - #{depth}"
end

p "Score - #{depth * horizontal}"
