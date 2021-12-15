# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

template, pairs = input.slice_when { _1 == '' }.to_a

@template, = template

letters = @template.split('')
first = letters.first
last = letters.last

@pairs = pairs.map { |pair| pair.split(' -> ') }.to_h

@pair_counts = Hash.new(0)

each_con2 = @template.split('').each_cons(2).map(&:join)

each_con2.each do |con2|
  @pair_counts[con2] += 1
end

pp @pair_counts

pp '--- start loop ---'

(0...40).each do |_i|
  new_counts = Hash.new(0)

  @pair_counts.each do |pair, count|
    a, b = pair.split('')
    middle = @pairs[pair]
    pair1 = [a, middle].join
    pair2 = [middle, b].join
    new_counts[pair1] += count
    new_counts[pair2] += count
  end
  # pp new_counts

  @pair_counts = new_counts

  # @template = @template.split('').zip(middles).flatten.join
  # pp @template.length
end

letter_counts = Hash.new(0)

@pair_counts.each do |pair, count|
  a, b = pair.split('')
  letter_counts[a] += count
  letter_counts[b] += count
end

letter_counts[first] += 1
letter_counts[last] += 1

min, max = letter_counts.values.minmax

pp (max / 2) - (min / 2)

## PART 1
# by_letter = @template.split('').group_by { _1 }

# by_letter.transform_values! { |v| v.length }

# min, max = by_letter.values.minmax

# pp max - min
