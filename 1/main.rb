# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

numbers = input.map(&:to_i)

# pp numbers.reduce([0, Float::INFINITY]) do |acc, value|
#   count, prev = acc
#   count += 1 if value > prev
#   [cound, value]
# end

count = 0
last_value = Float::INFINITY

numbers.each do |n|
  count += 1 if n > last_value
  last_value = n
end

pp count

#### PART 2

count = 0
last_value = Float::INFINITY

(0..numbers.length - 3).each do |idx|
  sum = numbers.slice(idx, 3).sum

  count += 1 if sum > last_value
  last_value = sum
end

pp count
