class BoardsController < ApplicationController
  def show
  end

  def create
    board = nil

    begin
      retries ||= 0
      board = Board.create!
    rescue
      retry if (retries += 1) < 3
    end

    redirect_to board_path(board)
  end
end
