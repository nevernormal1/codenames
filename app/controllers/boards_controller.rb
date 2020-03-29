class BoardsController < ApplicationController
  def show
    @board = Board.find_by(
      giver_link_token: params[:id]
    ) || Board.find_by(
      guesser_link_token: params[:id]
    )

    raise ActiveRecord::RecordNotFound unless @board

    @giver = params[:id] == @board.giver_link_token
    @clue = Clue.new

    @clues = @board.recent_clues
  end

  def create
    board = nil

    begin
      retries ||= 0
      board = Board.create!
    rescue => e
      logger.error e
      retry if (retries += 1) < 3
    end

    redirect_to board_path(id: board.giver_link_token)
  end
end
