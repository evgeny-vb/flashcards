# frozen_string_literal: true

# Model responsible for users on site
# User can have many cards
#
class User < ApplicationRecord
  has_many :cards

  validates :email, :password, presence: true
end
