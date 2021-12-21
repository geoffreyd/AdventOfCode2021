# frozen_string_literal: true

# Player 1 starting position: 3
# Player 2 starting position: 4

# Player 1 starting position: 4
# Player 2 starting position: 8

player1_pos = 4
player1_score = 0
player2_pos = 8
player2_score = 0

class Die
  def initialize(seed)
    @values = seed.digits(3)
    (0..30).each do |i|
      @values[i] ||= 0
    end
    pp "New Die #{@values} (seed #{seed})"
    # @pos = 0
    @rolls = 0
  end

  def roll
    val = @values[@rolls]
    @rolls += 1
    # pp "Rolled #{val + 1}"
    val + 1
  end

  def rolls
    @rolls
  end
end

def inc_pos(position, inc)
  new_pos = position + inc
  if new_pos > 10
    new_pos = new_pos - 10
  end
  new_pos
end

def play_game(start, rolls, target)
  score = 0
  turn = 1
  pos = start
  rolls.each do |roll|
    pos = inc_pos(pos, roll)
    score += pos
    if score >= target
      pp "turn #{turn} wone with score #{score}"
      return turn
    end
    turn += 1
  end
end

round = 0

p1_wins = 0
p2_wins = 0

(0..20).each do |i|
  die = Die.new(i)
end
die = Die.new(0)
loop do
  pp "start loop"
  p1_rolls = [die.roll, die.roll, die.roll]
  player1_pos = inc_pos(player1_pos, p1_rolls.sum)
  player1_score += player1_pos
  pp "p1 #{player1_score}"

  break if player1_score >= 21

  p2_rolls = [die.roll, die.roll, die.roll]
  player2_pos = inc_pos(player2_pos, p2_rolls.sum)
  player2_score += player2_pos
  pp "p1 #{player2_score}"

  break if player2_score >= 21

  round += 1
  pp "Rolls #{die.rolls}"
end


# die = Die.new(0)

# values = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
# p1_rolls, p2_rolls = values.each_slice(3)
#   .map{ _1.sum }
#   .partition.with_index { _2.even? }

# pp play_game(player1_pos, p1_rolls, 21)
# pp play_game(player2_pos, p2_rolls, 21)

