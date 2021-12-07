# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

positions = input[0].split(',').map(&:to_i)

min, max = positions.minmax

min_used = Float::INFINITY

(min..max).each do |target|
  fuel_used = positions.map { |p| (target - p).abs }.sum
  min_used = fuel_used if fuel_used < min_used
end

pp min_used
