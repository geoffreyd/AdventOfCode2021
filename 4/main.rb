require './bingo'

input = IO.readlines('./input.txt', chomp: true);

numbers = input.shift.split(",").map(&:to_i)

boards = []

input.each_slice(6) do |board_numbers|
  pp "---"
  board_numbers.shift
  board = []
  board_numbers.each do |row|
    board << row.split(/\W/).reject(&:empty?).map(&:to_i)
  end
  boards << board
end

bingo = Bingo.new(numbers, boards)

bingo.call


