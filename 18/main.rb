# frozen_string_literal: true

require('json')

input = IO.readlines('./sample.txt', chomp: true)

snailfish_lists = input.map { JSON.parse(_1) }



# processed_lists = snailfish_lists.map do |snailfish_list|
#   process_list(snailfish_list)
# end

def reduce_list(snailfish_list, depth: 0, return_early: false, mode: :explode)
  if snailfish_list.is_a? Numeric
    # pp "Found a number #{snailfish_list} - #{mode}"
    if snailfish_list > 9 && mode == :split
      num = snailfish_list / 2.0
      return [[num.floor, num.ceil], nil, nil, true]
    else
      return snailfish_list
    end
  end
  a, b = snailfish_list

  if depth >= 4
    return [0, a, b, true, depth]
  end

  reduced_a, add_l1, add_r1, early_left, l_depth = reduce_list(a, depth: depth + 1, mode: mode)
  if early_left
    # pp "Early exit left"
    reduced_b, add_l2, add_r2, early_right, r_depth = b, nil, nil, true, depth
  else
    reduced_b, add_l2, add_r2, early_right, r_depth = reduce_list(b, depth: depth + 1, mode: mode)
  end

  ret_a = if (reduced_a.is_a?(Numeric) && add_l2.is_a?(Numeric))
            # pp "Exploded left #{reduced_a} #{add_l2}"
            reduced_a + add_l2
          elsif (add_l2.is_a?(Numeric))
            set_in_right_most(reduced_a, add_l2)
          else
            reduced_a
          end

  ret_b = if (reduced_b.is_a?(Numeric) && add_r1.is_a?(Numeric))
            # pp "Exploded right #{reduced_b} #{add_r1}"
            reduced_b + add_r1
          elsif add_r1.is_a?(Numeric)
            set_in_left_most(reduced_b, add_r1)
          else
            reduced_b
          end

  [
    [ret_a, ret_b],
    add_l1,
    add_r2,
    return_early || early_left || early_right,
    [depth, l_depth, r_depth].compact.max
  ]
end

def set_in_left_most(numbers, value)
  if numbers.is_a? Numeric
    numbers + value
  else
    [set_in_left_most(numbers[0], value), numbers[1]]
  end
end

def set_in_right_most(numbers, value)
  if numbers.is_a? Numeric
    numbers + value
  else
    [numbers[0], set_in_right_most(numbers[1], value)]
  end
end

def add_lists(left, right)
  to_test = [left, right]
  last = nil
  mode = :explode
  explode_count = 0

  # repeat until the last run is the same as the current run
  while true
    # pp to_test

    to_test, _, _, _, depth = reduce_list(to_test, mode: mode)

    # pp "depth #{depth} - mode: #{mode} - explode_count: #{explode_count}"
    # pp "max #{to_test.flatten.max}"

    break if to_test == last && explode_count >= 1

    if mode == :split
      mode = :explode
      explode_count = 0
    elsif depth < 4 && to_test.flatten.max > 9
      mode = :split
      explode_count = 0
    # elsif to_test == last && mode == :split && depth >= 4
    #   mode = :explode
    #   explode_count = 0
    elsif to_test == last && mode == :explode
      explode_count += 1
    end


    last = to_test
  end

  last
end

# add_lists([[[[4,3],4],4],[7,[[8,4],9]]], [1,1])

# add_lists([[[0, [4, 5]], [0, 0]], [[[4, 5], [2, 6]], [9, 5]]], [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]])

sum = snailfish_lists.reduce do |acc, snailfish_list|
  pp "  #{acc}"
  pp "+ #{snailfish_list}"
  add_lists(acc, snailfish_list)
end

pp sum

def magnitude(numbers)
  a,b = numbers

  a_num = a.is_a?(Numeric) ? a : magnitude(a)
  b_num = b.is_a?(Numeric) ? b : magnitude(b)

  (a_num * 3) + (b_num * 2)
end

# mag_test = [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]]

pp magnitude sum