# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

positions = input[0].split(',').map(&:to_i)

min, max = positions.minmax

min_used = Float::INFINITY

@fact = {}
def fact(n)
  @fact[n] ||= (1..n).inject(:+) || 1
end

(min..max).each do |target|
  fuel_used = positions.map { |p| fact((target - p).abs) }.sum
  min_used = fuel_used if fuel_used < min_used
end

pp min_used
