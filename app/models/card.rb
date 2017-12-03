# frozen_string_literal: true

# Model responsible for cards
#
class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_difference

  before_validation :set_review_date, only: :create

  scope :by_review_date, -> { order(review_date: :desc) }

  private
  def text_difference
    return unless original_text.casecmp?(translated_text)
    errors.add(:translated_text, 'Оригинальный и переведенный текст не могут быть одинаковыми')
  end

  def set_review_date
    self.review_date = DateTime.now + 3.days
  end
end
