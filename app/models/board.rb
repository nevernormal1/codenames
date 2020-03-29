class Board < ApplicationRecord
  before_create :generate_link_tokens
  before_create :assign_words

  serialize :words

  private
  def generate_link_tokens
    self.giver_link_token = SecureRandom.hex(3)
    self.guesser_link_token = SecureRandom.alphanumeric(6)
  end

  def assign_words
    self.words = Word.limit(25).order("RANDOM()").pluck(:value)
  end
end
