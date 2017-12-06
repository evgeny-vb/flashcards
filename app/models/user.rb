# frozen_string_literal: true

# Model responsible for users on site
# User can have many cards
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :cards

  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, :crypted_password, presence: true
end
