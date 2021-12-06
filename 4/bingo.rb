# frozen_string_literal: true

require './board'

class Bingo
  def initialize(numbers, boards)
    @numbers = numbers
    @boards = boards.map { |board| Board.new(board) }
    @wonBoards = []
    # pp @boards.first.print
  end

  def call
    @numbers.each do |number|
      pp "calling #{number}"
      @boards.each do |board|
        next if @wonBoards.include? board

        board.number_called(number)
        next unless board.win?

        pp 'Board won!'
        board.print
        pp board.score
        @wonBoards << (board)
      end
    end
  end
end
