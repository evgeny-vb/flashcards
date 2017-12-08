# frozen_string_literal: true

# Model responsible for packs of cards
# Pack can have many cards
#
class Pack < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy

  validates :name, presence: true

  scope :current, -> { where(current: true) }

  def mark_as_current_for_user
    ActiveRecord::Base.transaction do
      user.packs.update_all(current: false)
      update!(current: true)
    end
  end
end
