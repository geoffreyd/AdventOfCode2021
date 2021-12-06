# frozen_string_literal: true

require './vents'

inputs = IO.readlines('./input.txt', chomp: true)

vents = Vents.new(1000)

inputs.each do |input|
  start_coords, end_coords = input.split(' -> ').map do |s|
    s.split(',').map(&:to_i)
  end

  vents.add_vents(start_coords, end_coords)
end

pp vents.score
