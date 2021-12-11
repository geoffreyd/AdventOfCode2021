# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

@height_map = height_map = input.map { _1.chars.map(&:to_i) }
@width = height_map.first.length
@depth = height_map.length
# pp "Map of #{width} x #{depth}"

def surrounding_points(y, x)
  [[y - 1, x], [y, x - 1], [y + 1, x], [y, x + 1]]
end

def surrounding(y, x)
  surrounding_points(y, x).map do |point|
    y, x = point
    value = @height_map.dig(y, x) if y >= 0 && y < @depth && x >= 0 && x < @width
    [y, x, value]
  end.filter { !_1[2].nil? && _1[2] != 9 }
end

low_points = []
height_map.each.with_index do |row, y|
  row.each.with_index do |current, x|
    t, l, r, b = surrounding_points(y, x).map { height_map.dig(*_1) }
    points = [t, l, r, b]
    low_points << [y, x, current] if current < points.compact.min
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
  dive(point, [point]).length
end

pp basins.sort.reverse.take(3).reduce(&:*)
