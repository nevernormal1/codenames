class Board < ApplicationRecord
  before_create :generate_link_token

  private
  def generate_link_token
    self.link_token = SecureRandom.hex(3)
  end
end
