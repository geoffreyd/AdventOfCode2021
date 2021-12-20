# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

algo, _, *image = input

buffer = 10

output = []

image = image.map { |line| line.split('') }
canvas = []
image.each.with_index do |line, ydx|
  new_y = ydx + buffer
  line.each.with_index do |pixel, xdx|
    new_x = xdx + buffer
    canvas[new_y] ||= []
    canvas[new_y][new_x] = pixel
  end
end
canvas.each.with_index do |line, _y|
  next if line.nil?

  len = line.length
  line[len + buffer] = '.'
end
canvas[canvas.length + buffer * 2] = []

def print_matrix(matrix, min_width = 0)
  matrix.each do |line|
    if line.nil?
      puts '.' * (min_width * 2)
    else
      puts line.map { _1.nil? ? '.' : _1 }.join
    end
  end
end

def surrounding_eight_points(point)
  x, y = point
  [
    [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
    [x - 1, y], [x, y], [x + 1, y],
    [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
  ]
end

def surrounding_values(matrix, point, gen)
  surrounding_points = surrounding_eight_points(point)
  # pp "surrounding points: #{surrounding_points}"
  surrounding_points.map { |p| matrix.dig(p[1], p[0]) || (gen.even? ? '#' : '.') }
end

@values = {
  '.' => 0,
  '#' => 1
}
def point_binary(matrix, point, gen)
  pixels = surrounding_values(matrix, point, gen)
  binary_string = pixels.map { @values[_1] }.join
  # pp "looking at #{point} - Pixels: #{pixels.join} -- binary string is #{binary_string}"
  int = binary_string.to_i(2)
end

# print_matrix(canvas, 50)

# pp point_binary(image, [0,0])

def inhance_image(image, algo, gen)
  new_canvas = image.map(&:dup)
  starting_y = image.find_index { _1&.include?('#') } - 3
  starting_x = image.map do |line|
    line.find_index { _1&.include?('#') } unless line.nil?
  end.compact.min - 3

  last_y = image.rindex { _1&.include?('#') } + 3
  last_x = image.map do |line|
    line.rindex { _1&.include?('#') } unless line.nil?
  end.compact.max + 3

  pp "starting at #{starting_x}, #{starting_y}"
  pp "ending at #{last_x}, #{last_y}"

  image[starting_y..last_y].each.with_index do |line, y_idx|
    y = y_idx + starting_y
    line ||= ['.'] * (last_x + starting_x)
    line[starting_x..last_x].each.with_index do |_pixel, x_idx|
      x = x_idx + starting_x
      algo_pos = point_binary(image, [x, y], gen)
      new_pixel = algo[algo_pos]
      # pp "new value is #{new_pixel} (#{algo_pos}) for #{x_idx}, #{y_idx} to go #{x}, #{y}"

      new_canvas[y] ||= []
      new_canvas[y][x] = new_pixel
    end
  end
  new_canvas
end

# pp algo_pos = point_binary(canvas, [111, 10])
# pp new_pixel = algo[algo_pos]

workingCanvas = canvas.map { _1.dup }
(1..2).each do |_idx|
  pp "Starting Gen #{_idx}"
  workingCanvas = inhance_image(workingCanvas, algo, _idx)
  print_matrix(workingCanvas)
end

start_x = buffer - 2
end_x = buffer + image.first.length + 2
start_y = buffer - 2
end_y = buffer + image.length + 2

output = workingCanvas[start_y..end_y].map do |line|
  line[start_x..end_x]
end

print_matrix(output)

pp output.flatten.compact.count { _1 == '#' }