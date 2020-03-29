module BoardsHelper
  def word_container_guessed_class(board, word, index)
    if board.guesses.pluck(:guess).include?(word)
      "guessed " + word_container_giver_class(board, word, index)
    end
  end

  def word_container_giver_class(board, word, index)
    if board.assassin == index
      "assassin"
    elsif board.blue.include?(index)
      "blue"
    elsif board.red.include?(index)
      "red"
    else
      ""
    end
  end
end
