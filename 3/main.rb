# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

counts = Array.new(input.first.length, 0)

input.each do |row|
  row.each_char.with_index do |i, idx|
    counts[idx] += i == '1' ? 1 : -1
  end
end
pp counts

gamma_bits = counts.map { |b| b.positive? ? 1 : 0 }
# epsilon_bits = counts.map { |b| b > 0 ? 0 : 1 }
pp gamma_bits

gamma = gamma_bits.join.to_i(2)
epsilon = gamma_bits.join.gsub(/\d/, { '0' => '1', '1' => '0' }).to_i(2)

pp "part 1: #{gamma * epsilon}"

def most_at(array, match, idx)
  eq, neq = array.partition { |i| i[idx] == match }
  eq.length >= neq.length ? eq : neq
end

def least_at(array, match, idx)
  eq, neq = array.partition { |i| i[idx] == match }
  eq.length > neq.length ? neq : eq
end

first_check = counts[0] >= 0 ? '1' : '0'
ox, co = input.partition do |i|
  i[0] == first_check
end

(1...input.first.length).each do |i|
  # pp "Looking at index #{i}"
  # puts ox.inspect + "\n"

  ox = most_at(ox, '1', i) if ox.length > 1

  # puts co.inspect + "\n"
  next unless co.length > 1

  co = least_at(co, '0', i)
end

pp ox
pp co

pp "Part 2: #{ox.first.to_i(2) * co.first.to_i(2)}"
