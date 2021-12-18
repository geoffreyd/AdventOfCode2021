# frozen_string_literal: true

# input = IO.readlines('./input.txt', chomp: true).first
# [32..65, y=-225..-177"
# x=20..30, y=-10..-5
start = [0,0]

# input_1 = [20, -10]
# input_2 = [30, -5]

# x=32..65, y=-225..-177
input_1 = [32, -225]
input_2 = [65, -177]



def lands_in_zone(velocity_x, velocity_y, start_point, target_area)
  max_x = [target_area[0][0], target_area[1][0]].max
  max_y = [target_area[0][1], target_area[1][1]].min

  prob_pos = [0,0]
  highest_y = 0

  while !in_zone?(prob_pos, target_area)
    if out_of_bounds(prob_pos, max_x, max_y)
      # pp "Out of bounds!"
      # pp prob_pos
      return nil
    end

    prob_pos = [prob_pos[0] + velocity_x, prob_pos[1] + velocity_y]
    if prob_pos[1] > highest_y
      highest_y = prob_pos[1]
    end
    # pp prob_pos

    velocity_x = [velocity_x - 1, 0].max
    velocity_y -= 1

  end
  pp "Landed in zone!"
  pp "Starting point: #{velocity_x}, #{velocity_y}"
  pp prob_pos
  highest_y
end

def in_zone?(point, target_area)
  point[0] >= target_area[0][0] &&
  point[0] <= target_area[1][0] &&
  point[1] >= target_area[0][1] &&
  point[1] <= target_area[1][1]
end

def out_of_bounds(point, max_x, max_y)
  point[0] > max_x || point[1] < max_y
end

pp "input #{input_1}, #{input_2}"

highest_ys = []

# highest_ys << lands_in_zone(10, 50, start, [input_1, input_2])

(1..500).each do |x|
  (-500..500).each do |y|
    highest_ys << lands_in_zone(x,y, start, [input_1, input_2])
  end
end

pp highest_ys.compact.length
