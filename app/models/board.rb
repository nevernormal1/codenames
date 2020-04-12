class Board < ApplicationRecord
  before_create :generate_link_tokens
  before_create :assign_words
  before_create :assign_colors

  serialize :words
  serialize :blue
  serialize :red

  enum turn: [:blue, :red]

  has_many :clues
  has_many :guesses
  has_many :recent_clues, -> { order(id: :desc).limit(10) }, class_name: "Clue"
  has_many :recent_guesses, -> { order(id: :desc).limit(10) }, class_name: "Guess"
  has_one :last_clue, -> { order(id: :desc) }, class_name: "Clue"
  has_one :last_guess, -> { order(id: :desc) }, class_name: "Guess"

  def change_turns!
    if turn == "blue"
      self.turn = :red
    else
      self.turn = :blue
    end

    save!
  end

  def guessing?
    last_clue && turn == self.class.turns.key(last_clue.turn)
  end

  def game_over?
    last_guess&.assassin? || all_clues_guessed?
  end

  def blue_words_remaining
    blue.size - (blue & guess_indices).size
  end

  def red_words_remaining
    red.size - (red & guess_indices).size
  end

  private
  def guess_indices
    @guess_indices ||= guesses.pluck(:guess).map do |guess|
      words.index(guess)
    end
  end

  def all_clues_guessed?
    (blue & guess_indices).size == blue.size ||
      (red & guess_indices).size == red.size
  end

  def generate_link_tokens
    self.giver_link_token = SecureRandom.hex(3)
    self.guesser_link_token = SecureRandom.alphanumeric(6)
  end

  def assign_words
    self.words = Word.limit(25).order("RANDOM()").pluck(:value)
  end

  def assign_colors
    random_squares = (0..24).to_a.shuffle
    self.assassin = random_squares.shift
    extra = random_squares[0..8]
    less = random_squares[9..16]

    if rand < 0.5
      self.blue = extra
      self.red = less
      self.turn = :blue
    else
      self.red = extra
      self.blue = less
      self.turn = :red
    end
  end
end
