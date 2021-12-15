# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

@numbers = input.map { |n| n.to_s.chars.map(&:to_i) }

@size = @numbers.length

@max_cost = (@size + @size) * 9 - 9

@paths = []

def surrounding_points(y, x)
  [
    [y - 1, x],
    [y, x - 1], [y, x + 1],
     [y + 1, x]
  ]
end

def surrounding(y, x)
  surrounding_points(y, x).map do |point|
    y, x = point
    value = @numbers.dig(y, x) if y >= 0 && y < @size && x >= 0 && x < @size
    [y, x, value]
  end.filter { !_1[2].nil? }
end

def path_cost(path)
  path.map { |_, _, value| value }.sum
end

# Find the cheapest path from the top left corner to the bottom right corner
def find_cheapest_path
  queue = [[0, 0, 0]]
  visited = {}
  until queue.empty?
    cost, y, x = queue.shift
    next if visited[[y, x]] && visited[[y, x]] <= cost

    visited[[y, x]] = cost
    surrounding(y, x).each do |y, x, value|
      next if visited[[y, x]] && visited[[y, x]] <= (cost + value)

      queue << [cost + value, y, x]
    end
  end
  pp visited
  visited[[@size - 1, @size - 1]]
end


pp find_cheapest_path