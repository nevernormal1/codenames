class GuessesController < ApplicationController
  def create
    link_token = params[:board][:guesser_link_token]
    @board = Board.find_by!(
      guesser_link_token: link_token
    )

    guess = @board.guesses.build(guess_params)
    if guess.guess.blank?
      @board.change_turns!
    else
      Board.transaction do
        guess.save!
        if !guess.correct?
          @board.change_turns!
        end
      end
    end

    redirect_to board_path(id: link_token)
  end

  private
  def guess_params
    params.require(:guess).permit(:guess, :turn)
  end
end
