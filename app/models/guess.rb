class Guess < ApplicationRecord
  belongs_to :board

  def correct?
    index = board.words.index(guess)
    if Board.turns.key(turn) == "red"
      board.red.include?(index)
    else
      board.blue.include?(index)
    end
  end

  def assassin?
    index = board.words.index(guess)

    board.assassin == index
  end
end
