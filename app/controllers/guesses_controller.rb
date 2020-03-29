class GuessesController < ApplicationController
  def create
    link_token = params[:board][:guesser_link_token]
    @board = Board.find_by!(
      guesser_link_token: link_token
    )

    @board.guesses.create!(guess_params)

    redirect_to board_path(id: link_token)
  end

  private
  def guess_params
    params.require(:guess).permit(:guess, :turn)
  end
end
