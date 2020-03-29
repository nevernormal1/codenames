module BoardsHelper
  def word_container_class(board, word, index)
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
