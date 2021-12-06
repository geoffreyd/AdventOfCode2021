# frozen_string_literal: true

require_relative './lanternfish'

age_count = [0, 0, 0, 0, 0, 0, 0, 0, 0]

# initial_ages = [3, 4, 3, 1, 2]
initial_ages = [3, 5, 1, 2, 5, 4, 1, 5, 1, 2, 5, 5, 1, 3, 1, 5, 1, 3, 2, 1, 5, 1, 1, 1, 2, 3, 1, 3, 1, 2, 1, 1, 5, 1, 5, 4, 5, 5, 3, 3, 1, 5, 1, 1, 5, 5, 1, 3, 5, 5, 3, 2, 2,
                4, 1, 5, 3, 4, 2, 5, 4, 1, 2, 2, 5, 1, 1, 2, 4, 4, 1, 3, 1, 3, 1, 1, 2, 2, 1, 1, 5, 1, 1, 4, 4, 5, 5, 1, 2, 1, 4, 1, 1, 4, 4, 3, 4, 2, 2, 3, 3, 2, 1, 3, 3, 2, 1, 1, 1, 2, 1, 4, 2, 2, 1, 5, 5, 3, 4, 5, 5, 2, 5, 2, 2, 5, 3, 3, 1, 2, 4, 2, 1, 5, 1, 1, 2, 3, 5, 5, 1, 1, 5, 5, 1, 4, 5, 3, 5, 2, 3, 2, 4, 3, 1, 4, 2, 5, 1, 3, 2, 1, 1, 3, 4, 2, 1, 1, 1, 1, 2, 1, 4, 3, 1, 3, 1, 2, 4, 1, 2, 4, 3, 2, 3, 5, 5, 3, 3, 1, 2, 3, 4, 5, 2, 4, 5, 1, 1, 1, 4, 5, 3, 5, 3, 5, 1, 1, 5, 1, 5, 3, 1, 2, 3, 4, 1, 1, 4, 1, 2, 4, 1, 5, 4, 1, 5, 4, 2, 1, 5, 2, 1, 3, 5, 5, 4, 5, 5, 1, 1, 4, 1, 2, 3, 5, 3, 3, 1, 1, 1, 4, 3, 1, 1, 4, 1, 5, 3, 5, 1, 4, 2, 5, 1, 1, 4, 4, 4, 2, 5, 1, 2, 5, 2, 1, 3, 1, 5, 1, 2, 1, 1, 5, 2, 4, 2, 1, 3, 5, 5, 4, 1, 1, 1, 5, 5, 2, 1, 1]

initial_ages.each do |age|
  age_count[age] += 1
end

pp age_count

256.times.each do
  # new_ages = [0, 0, 0, 0, 0, 0, 0, 0, 0]

  # (1..8).each do |i|
  #   # pp "new ages #{i} getting set to #{age_count[i - 1]}"
  #   new_ages[i -1] = age_count[i]
  # end

  # new_ages[8] = age_count[0]
  # new_ages[6] += age_count[0]
  # age_count = new_ages

  to_be_born = age_count[0]
  age_count[0] = 0
  age_count = age_count.rotate
  age_count[6] += to_be_born
  age_count[8] += to_be_born

  # pp age_count
end

pp age_count.sum
