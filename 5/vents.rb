class Vents
  X = 0
  Y = 1

  def initialize(size)
    @map = size.times.map { |_| Array.new(size, 0) }
  end

  def add_vents(start, finish)
    pp "Adding #{start} -> #{finish}"
    if start[X] == finish[X]
      # pp "Adding #{start} -> #{finish}"
      x = start[X]
      ys = [start[Y], finish[Y]].sort
      (ys[0]..ys[1]).each do |y|
        @map[y][x] += 1
      end
    elsif start[Y] == finish[Y]
      # pp "Adding #{start} -> #{finish}"
      y = start[Y]
      xs = [start[X], finish[X]].sort
      (xs[0]..xs[1]).each do |x|
        @map[y][x] += 1
      end
    else
      step_x = start[X] > finish[X] ? -1 : 1
      step_y = start[Y] > finish[Y] ? -1 : 1
      coords = (start[X]..finish[X]).step(step_x)
                                    .zip((start[Y]..finish[Y]).step(step_y))
      coords.each do |xy|
        x, y = xy
        @map[y][x] += 1
      end
    end
    print
  end

  def print
    @map.each_with_index do |row, idx|
      p "#{idx}: " + row.join(' ').gsub('0', '.')
    end
  end

  def score
    # print
    @map.map do |row|
      count = row.sum { |i| i >= 2 ? 1 : 0 }
      # pp "row has #{count}"
      count
    end.sum
  end
end
