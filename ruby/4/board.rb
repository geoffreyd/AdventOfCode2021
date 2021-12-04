class Board
  def initialize(numbers)
    @numbers = numbers
    @called = [
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0],
      [0,0,0,0,0]
    ]
    @lastCalled = nil
  end

  def number_called(number)
    @lastCalled = number
    @numbers.each_with_index do |row, idx|
      i = row.find_index(number)
      @called[idx][i] = 1 if i
    end
  end

  def win?
    @called.any? { |row| row.sum == 5 } ||
      @called.transpose.any? { |row| row.sum == 5 }
  end

  def score
    score = 0
    @called.each_with_index do |row, idx|
      row.each_with_index do |checked, idy|
        if checked == 0
          score += @numbers[idx][idy]
        end
      end
    end
    score  * @lastCalled
  end

  def diagonal_win?
    c = @called
    c[0][0] + c[1][1] + c[2][2] + c[3][3] + c[4][4] == 5 ||
    c[0][4] + c[1][3] + c[2][2] + c[3][1] + c[4][0] == 5
  end

  def print
    pp @numbers
    pp '--'
    pp @called
    pp '---------------'
  end
end