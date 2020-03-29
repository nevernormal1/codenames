class BoardsController < ApplicationController
  def show
  end

  def create
    board = Board.create!
    redirect_to board_path(board)
  end

  private
end
