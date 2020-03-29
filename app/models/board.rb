class Board < ApplicationRecord
  before_create :generate_link_token
  before_create :assign_words

  serialize :words

  private
  def generate_link_token
    self.link_token = SecureRandom.hex(3)
  end

  def assign_words
    self.words = Word.limit(25).order("RANDOM()").pluck(:value)
  end
end
