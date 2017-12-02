# Model responsible for cards
#
class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
end