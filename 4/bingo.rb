require './board'

class Bingo
  def initialize(numbers, boards)
    @numbers = numbers
    @boards = boards.map {|board| Board.new(board) }
    # pp @boards.first.print
  end

  def call
    @numbers.each do |number|
      @boards.each do |board|
        board.number_called(number)
        if board.win?
          pp "Board won!"
          board.print
          pp board.score
          raise "done."
        end

      end
    end
  end

end