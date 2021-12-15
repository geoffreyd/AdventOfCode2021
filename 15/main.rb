# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

@numbers = input.map { |n| n.to_s.chars.map(&:to_i) }

@size = @numbers.length

@max_cost = (@size + @size) * 9 - 9

@paths = []

def surrounding_points(y, x)
  [
    [y - 1, x],
    [y, x - 1],
    [y, x + 1],
    [y + 1, x]
  ]
end

def surrounding(matrix, y, x, size)
  surrounding_points(y, x).map do |point|
    y, x = point
    value = matrix.dig(y, x) if y >= 0 && y < size && x >= 0 && x < size
    [y, x, value]
  end.filter { !_1[2].nil? }
end

def path_cost(path)
  path.map { |_, _, value| value }.sum
end

# Find the cheapest path from the top left corner to the bottom right corner
def find_cheapest_path(matrix)
  size = matrix.length
  queue = [[0, 0, 0]]
  visited = {}
  until queue.empty?
    cost, y, x = queue.pop
    next if visited[[y, x]] && visited[[y, x]] <= cost

    visited[[y, x]] = cost
    surrounding(matrix, y, x, size).each do |y, x, value|
      next if visited[[y, x]] && visited[[y, x]] <= (cost + value)

      queue << [cost + value, y, x]
    end
  end
  pp visited
  visited[[size - 1, size - 1]]
end

def distance_to_point(start, finish)
  (finish[0] - start[0]).abs + (finish[1] - start[1]).abs
end

def print_path(cameFrom, current, path=[])
  return path.reverse if current.nil?

  print_path(cameFrom, cameFrom[current], path + [current])
end

# use the A* algorithm to find the cheapest path
def find_cheapest_path_a_star(matrix)
  size = matrix.length
  queue = [[0, 0, 0]]
  cameFrom = {}

  gScore = Hash.new(Float::INFINITY)
  gScore[[0, 0]] = 0

  fScore = Hash.new(Float::INFINITY)
  fScore[[0, 0]] = distance_to_point([0, 0], [size - 1, size - 1])

  found = nil

  until queue.empty?
    # pp "queue: #{queue}"
    current = queue.min_by { |_, x, y| fScore[[x, y]] }
    cost, x, y = current
    current_point = [x, y]
    # pp "looking at #{current}"
    if [x,y] == [size - 1, size - 1]
      found = current_point
      pp print_path cameFrom, found
      return cost
    end

    queue.delete(current)
    neighbours = surrounding(matrix, x, y, size)
    # pp "neighbours #{neighbours}"
    neighbours.each do |ny, nx, value|
      neighbour = [ny, nx]
      tentative_gScore = gScore[current_point] + value
      # pp "checking Score #{tentative_gScore} vs #{gScore[neighbour]}"
      if tentative_gScore < gScore[neighbour]
        cameFrom[neighbour] = current_point
        gScore[neighbour] = tentative_gScore
        fScore[neighbour] = tentative_gScore + distance_to_point(neighbour, [size - 1, size - 1])
        queue.push([tentative_gScore, nx, ny]) unless queue.include?(neighbour)
      end
    end
  end
  print_path cameFrom, found
  found
end

# repeat the given matrix n times, increasing the cost of each number by n
def repeat_x_matrix(matrix, n)
  new_matrix = []

  matrix.each do |row|
    new_row = row
    length = row.length
    n.times do |i|
      last_chunk = new_row[(length * i)..-1]
      last_chunk.each do |value|
        new_row << (value == 9 ? 1 : (value + 1))
      end
    end
    new_matrix << new_row
  end
  new_matrix
end

def repeat_y_matrix(matrix, n)
  new_matrix = matrix.clone

  col_size = matrix.length

  n.times do |i|
    # pp "times #{i} - #{col_size}"
    # print_matrix new_matrix[(col_size * i)..]
    new_matrix[(col_size * i)..].each do |row|
      # pp "Row #{row}"
      new_row = []
      row.each do |value|
        new_row << (value == 9 ? 1 : (value + 1))
      end
      new_matrix << new_row
    end
  end
  new_matrix
end

def print_matrix(matrix)
  matrix.each do |row|
    puts row.join(' ')
  end
end
mx = repeat_x_matrix(@numbers, 4)
# print_matrix mx

final_matrix = repeat_y_matrix(mx, 4)

# print_matrix final_matrix

pp find_cheapest_path final_matrix
# pp find_cheapest_path_a_star final_matrix
