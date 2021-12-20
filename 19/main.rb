# frozen_string_literal: true

input = IO.readlines('./sample_basic.txt', chomp: true)

# @dots, instructions = input.slice_when { _1 == '' }.to_a

# split array when there is a line that looks like "--- scanner * ---"
scanners = input
  .reject(&:empty?)
  .slice_when { |a,b| b.match(/^--- scanner \d+ ---$/) }
  # remove the first item of each array
  .map { _1.shift; _1.map{ |line| line.split(',').map(&:to_i) } }

pp scanners

def offset_matrix(matrix, offset_x, offset_y)
  matrix.map do |point|
    x, y = point
    [x + offset_x, y + offset_y]
  end
end

def compare_scanners(matrix1, matrix2)
  overlaps = []
  pp ""
  pp "--- Comparing ---"
  pp print_matrix matrix1
  pp "- - - - - - - - -"
  (-6..6).each do |x|
    (-6..6).each do |y|
      offset_2 = offset_matrix(matrix2, x, y)
      compare = matrix1.intersection(offset_2)
      pp print_matrix(offset_2)
      if compare.length > 3
        overlaps << compare
      end
    end
  end
  pp "overlaps: #{overlaps}"
end

def normalise_matrix(matrix)
  smallest_x = matrix.map { |point| point[0] }.min.abs
  smallest_y = matrix.map { |point| point[1] }.min.abs

  matrix.map do |point|
    x, y = point
    [x - smallest_x, y - smallest_y]
  end
end

def print_matrix(matrix)
  # smallest_x = matrix.map { |point| point[0] }.min.abs
  # smallest_y = matrix.map { |point| point[1] }.min.abs
  chart = [['S']]

  matrix.uniq.each do |dot|
    x, y = dot
    chart[y] ||= []
    chart[y][x] = '#'
  end

  pp "chart: #{chart}"
  chart.each do |row|
    puts row.map { _1 == '#' ? '#' : ' ' }.join('')
  end
end

def find_offset_for_overlapping_matrix(matrix1, matrix2)

end

# given 2 3d arrays, of points with relative distance from origin, find the overlapping points
def find_overlapping_points(a, b)
  a.map do |point|
    b.map do |other_point|
      if point == other_point
        point
      end
    end.compact
  end.flatten.uniq
end

normalized = scanners.map do |scanner|
  normalise_matrix(scanner)
end


compare_scanners(normalized[0], normalized[1])
