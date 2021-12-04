
input = IO.readlines('./input.txt', chomp: true);

numbers = input.map(&:to_i)

# pp numbers.reduce([0, Float::INFINITY]) do |acc, value|
#   count, prev = acc
#   count += 1 if value > prev
#   [cound, value]
# end

count = 0
last_value = Float::INFINITY

numbers.each do |n|
  count +=1 if n > last_value
  last_value = n
end

pp count
