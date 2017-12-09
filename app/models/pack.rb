# frozen_string_literal: true

# Model responsible for packs of cards
# Pack can have many cards
#
class Pack < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true
end
