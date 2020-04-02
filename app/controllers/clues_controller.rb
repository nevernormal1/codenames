class CluesController < ApplicationController
  def create
    link_token = params[:board][:giver_link_token]
    @board = Board.find_by!(
      giver_link_token: link_token
    )

    Board.transaction do
      @board.clues.create!(clue_params)
      @board.touch
    end

    redirect_to board_path(id: link_token)
  end

  private
  def clue_params
    params.require(:clue).permit(:turn, :clue, :number)
  end
end
