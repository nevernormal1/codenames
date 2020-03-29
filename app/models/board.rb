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
  has_one :last_clue, -> { order(id: :desc) }, class_name: "Clue"

  def change_turns!
    if turn == "blue"
      self.turn = :red
    else
      self.turn = :blue
    end

    save!
  end

  def guessing?
    turn == self.class.turns.key(last_clue.turn)
  end

  private
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
