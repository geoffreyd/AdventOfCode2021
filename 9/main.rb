# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

@height_map = height_map = input.map { _1.chars.map(&:to_i) }

@width = width = height_map.first.length
@depth = depth = height_map.length

pp "Map of #{width} x #{depth}"

low_points = []

def surrounding_points(y, x)
  [
    [y - 1, x],
    [y, x - 1],
    [y + 1, x],
    [y, x + 1]
  ]
end

def surrounding(y, x)
  surrounding_points(y, x).map do |point|
    y, x = point
    value = @height_map.dig(y, x) if y >= 0 && y < @depth && x >= 0 && x < @width
    [y, x, value]
  end.filter { !_1[2].nil? && _1[2] != 9 }
end

height_map.each.with_index do |row, y|
  row.each.with_index do |current, x|
    # pp height_map

    t = height_map.dig(y - 1, x) if y - 1 >= 0
    l = height_map.dig(y, x - 1) if x - 1 >= 0
    b = height_map.dig(y + 1, x) if y + 1 < depth
    r = height_map.dig(y, x + 1) if x + 1 < width

    points = [t, l, r, b]
    # pp "checking #{current} - #{points} for #{x} #{y}"

    low_points << [y, x, current] if current < [t, l, r, b].compact.min
  end
end

def dive(point, found)
  y, x, = point
  around = surrounding(y, x)
  new_points = around.reject { found.include? _1 }

  return found if new_points.length.zero?

  new_points.each do |new_point|
    found = dive(new_point, found.concat(new_points))
  end
  found.uniq
end

basins = low_points.map do |point|
  y, x, _value = point
  found = [point]

  found = dive(point, found)

  found.length
end

pp basins.sort.reverse.take(3).reduce(&:*)
