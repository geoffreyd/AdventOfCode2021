# frozen_string_literal: true


input = IO.readlines('./input.txt', chomp: true)

height_map = input.map { _1.chars.map(&:to_i) }

width = height_map.first.length
depth = height_map.length

pp height_map.first
pp "Map of #{width} x #{depth}"

low_points = []

height_map.each.with_index do |row, y|
  row.each.with_index do |current, x|
    # pp height_map

    t = height_map.dig(y - 1, x) if y-1 >= 0
    l = height_map.dig(y, x - 1) if x-1 >= 0
    b = height_map.dig(y + 1, x) if y + 1 < depth
    r = height_map.dig(y, x + 1) if x + 1 < width

    points = [t, l, r, b]
    # pp "checking #{current} - #{points} for #{x} #{y}"

    low_points << current if current < [t, l, r, b].compact.min
  end
end

pp low_points.sum + low_points.length
