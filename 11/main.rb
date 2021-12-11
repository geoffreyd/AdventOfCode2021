# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

@octo_map = input.map { _1.chars.map(&:to_i) }
@width = @octo_map.first.length
@depth = @octo_map.length

def surrounding_points(y, x)
  [
    [y - 1, x - 1], [y - 1, x], [y - 1, x + 1],
    [y, x - 1],                 [y, x + 1],
    [y + 1, x - 1], [y + 1, x], [y + 1, x + 1]
  ]
end

def surrounding(y, x)
  surrounding_points(y, x).map do |point|
    y, x = point
    value = @octo_map.dig(y, x) if y >= 0 && y < @depth && x >= 0 && x < @width
    [y, x, value]
  end.filter { !_1[2].nil? }
end

# raise surrounding(3, 3).inspect

# pp @octo_map
@flashes = 0

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

def step
  @octo_map = @octo_map.map do |row|
    row.map { _1 + 1 }
  end
end

def built_up
  over_9 = []
  @octo_map.each.with_index do |row, y|
    row.each.with_index do |current, x|
      over_9 << [y, x] if current > 9 && !@flashed_this_round.include?([y, x])
    end
  end
  over_9
end

def flash(to_flash)
  to_flash.each do |point|
    y, x = point
    next unless @octo_map[y][x] > 9

    @flashes += 1
    @flashed_this_round << point
    surrounding(y, x).each do |around_point|
      ay, ax, = around_point
      @octo_map[ay][ax] += 1
    end
  end
end

def zero_things
  @octo_map.each.with_index do |row, y|
    row.each.with_index do |current, x|
      @octo_map[y][x] = 0 if current > 9
    end
  end
end

@flashed_this_round = []

def print_flashed
  @octo_map.each.with_index do |row, y|
    pp row.map.with_index { @flashed_this_round.include?([y, _2]) ? '-' : _1 }.join(',')
  end
end

1000.times do |round|
  pp "NEW ROUND ---------- #{round}"
  @flashed_this_round = []
  step
  # print_flashed
  @to_flash = built_up
  while @to_flash.length.positive?
    flash(@to_flash)
    @to_flash = built_up
  end
  # print_flashed
  zero_things
  break if @octo_map.all? { |row| row.all?(&:zero?) }
end

# pp @octo_map

pp @flashes
