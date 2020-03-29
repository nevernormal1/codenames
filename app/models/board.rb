class Board < ApplicationRecord
  before_create :generate_link_tokens
  before_create :assign_words
  before_create :assign_colors

  serialize :words
  serialize :blue
  serialize :red

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
    else
      self.red = extra
      self.blue = less
    end
  end
end
