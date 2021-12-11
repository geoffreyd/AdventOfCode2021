# frozen_string_literal: true

require 'pry'

input = IO.readlines('./input.txt', chomp: true)

rows = input.map(&:chars)

matches = {
  '<' => '>',
  '{' => '}',
  '[' => ']',
  '(' => ')'
}

scores = {
  '>' => 25_137,
  '}' => 1197,
  ']' => 57,
  ')' => 3
}
closeing_scores = {
  '<' => 4,
  '{' => 3,
  '[' => 2,
  '(' => 1
}

score = 0
scores2 = []

rows.reject do |row|
  opens = []
  invalid = false
  row.each do |char|
    if ['<', '[', '{', '('].include? char
      # pp "Adding #{char}"
      opens << char
    else
      last = opens.last
      if matches[last] == char
        opens.pop
      else
        # pp "Expected #{matches[last]}, but found #{char} instead."
        score += scores[char]
        invalid = true
        break
      end
    end
  end
  next if invalid

  row_score = 0
  opens = opens.reverse
  # pp opens.join(", ")
  # pp "Score: #{row_score}"
  opens.each do |open|
    row_score *= 5
    # pp "*5 #{row_score}"
    row_score += closeing_scores[open]
    # pp "+ #{closeing_scores[open]} - #{row_score}"
  end
  scores2 << row_score
end

scores2.sort!
pp scores2[(scores2.length / 2).ceil]
