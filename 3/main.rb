# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

counts = Array.new(input.first.length, 0)

input.each do |row|
  row.each_char.with_index do |i, idx|
    counts[idx] += i == '1' ? 1 : -1
  end
end
pp counts

gamma_bits = counts.map { |b| b > 0 ? 1 : 0 }
epsilon_bits = counts.map { |b| b > 0 ? 0 : 1 }

gamma = gamma_bits.join.to_i(2)
epsilon = epsilon_bits.join.to_i(2)

pp gamma * epsilon
