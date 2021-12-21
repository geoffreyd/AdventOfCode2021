
# player1_pos = 4
# player2_pos = 8

player1_pos = 3
player2_pos = 4
player1_score = 0
player2_score = 0


def inc_pos(position, inc)
  new_pos = position + inc
  if new_pos > 10
    new_pos = new_pos - 10
  end
  new_pos
end

def move(start, rolls)
  inc_pos(start, rolls.sum)
end


games_won = {
  0 => 0,
  1 => 0
}

@roll_memos = {}

def roll_dice(positions, games_won, current_player = 0, current_scores = [0,0], rolls = [])
  if games_won[0] % 100000 == 0
    pp "roll #{positions}, #{games_won}, [#{current_player}] - #{current_scores} -- #{rolls}"
  end
  if rolls.length == 3
    if @roll_memos[positions + current_scores]
      return @roll_memos[positions + current_scores]
    end
    new_pos = inc_pos(positions[current_player], rolls.sum)
    current_scores = current_scores.dup
    positions = positions.dup
    current_scores[current_player] += new_pos
    positions[current_player] = new_pos
    if current_scores[current_player] >= 12
      # pp "won game! with score [#{current_scores[current_player]}] as pos '#{new_pos}'"
      games_won[current_player] += 1
      return [games_won[0], games_won[1]]
    end
    current_player = current_player == 0 ? 1 : 0;
    rolls = []
  end
  [1,2].each do |roll|
    wins = roll_dice(positions, games_won, current_player, current_scores, rolls.dup << roll)
    []
  end
end


def count_win(pos1, pos2, score1, score2)
  if score1 >= 21
    return [1,0]
  end
  if score2 >= 21
    return [0,1]
  end
  if @roll_memos[[pos1, pos2, score1, score2]]
    return @roll_memos[[pos1, pos2, score1, score2]]
  end

  result = [0,0]
  [1, 2, 3].each do |d1|
    [1, 2, 3].each do |d2|
      [1, 2, 3].each do |d3|
        new_pos1 = (pos1 + d1 + d2 + d3) % 10
        new_score1 = score1 + new_pos1 + 1

        winsA, winsB = count_win(pos2, new_pos1, score2, new_score1)
        result = [result[0] + winsB, result[1] + winsA]
      end
    end
  end
  @roll_memos[[pos1, pos2, score1, score2]] = result
  result
end

# roll_dice([player1_pos, player2_pos], games_won)

counts = count_win(player1_pos - 1, player2_pos - 1, 0, 0)
pp "WON GAMES: #{counts}"

