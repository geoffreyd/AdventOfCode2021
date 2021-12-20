# frozen_string_literal: true

require_relative './scanner'

input = IO.readlines('./input.txt', chomp: true)

# @dots, instructions = input.slice_when { _1 == '' }.to_a

# split array when there is a line that looks like "--- scanner * ---"
scanners = input
  .reject(&:empty?)
  .slice_when { |a,b| b.match(/^--- scanner \d+ ---$/) }
  # remove the first item of each array
  .map { _1.shift; _1.map{ |line| line.split(',').map(&:to_i) } }
  .map.with_index { |scanner, idx| Scanner.new(idx, scanner) }

# pp scanners

def compare_scanners(distances1, distances2, delta)
  intersection = distances1.first(delta).intersection(distances2.first(delta))
  pp "Found #{intersection.length} intersections"
  intersection.length >= delta
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


# distances = scanners.map do |scanner|
#   scanner.map do |point|
#     scanner.map do |other_point|
#       distance_between_points(point, other_point)
#     end.sort
#   end
# end

# scanners.each.with_index do |scanner, idx|
#   scanners.each.with_index do |other_scanner, other_idx|
#     next if other_idx >= idx

#     ols = scanner.overlapping_beacons(other_scanner)
#     pp "Scanner #{scanner.id} is overlapping #{other_scanner.id} with #{ols.length} beacons" if ols.length > 0
#   end
# end



distances = scanners.map do |scanner|
  scanner.sorted_distances
end.flatten(1).uniq

# distances.each do |distance|
#   puts distance.join(",")
# end

pp "Starting with #{distances.length} distances"

distances.delete_if do |beacon|
  overlaps = distances.select do |other|
    next if beacon == other
    beacon.intersection(other).length > 10
  end
  if overlaps.length > 0
    pp "has overlaps: #{overlaps}"
    true
  else
    false
  end
end

pp distances.length