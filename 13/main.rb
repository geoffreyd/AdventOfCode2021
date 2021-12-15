# frozen_string_literal: true

input = IO.readlines('./input.txt', chomp: true)

@dots, instructions = input.slice_when { _1 == '' }.to_a

@dots = @dots.reject { _1 == '' }

def fold_up(fold)
  @dots.each.with_index do |dot, idx|
    x, y = dot.split(',').map(&:to_i)

    if y > fold
      dist = y - fold
      new_y = fold - dist
      @dots[idx] = [x, new_y].join(',')
    end
  end
end

def fold_left(fold)
  @dots.each.with_index do |dot, idx|
    x, y = dot.split(',').map(&:to_i)

    if x > fold
      dist = x - fold
      new_x = fold - dist
      @dots[idx] = [new_x, y].join(',')
    end
  end
end

instructions.each do |instruction|
  direction, loc = instruction.split('=')
  direction = direction[-1]
  case direction
  when 'x'
    fold_matrix_left(@dots, loc.to_i)
  when 'y'
    fold_up(loc.to_i)
  end
  # Part 1 - print on first loop
  # pp @dots.sort
  # pp @dots.uniq.length
end

chart = []

@dots.uniq.each do |dot|
  x, y = dot.split(',').map(&:to_i)
  chart[y] ||= []
  chart[y][x] = '#'
end

chart.each do |row|
  pp row.map { _1 == '#' ? '#' : ' ' }.join('')
end
