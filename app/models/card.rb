# frozen_string_literal: true

# Model responsible for cards
#
class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_difference

  before_validation :set_review_date, only: :create

  scope :sort_by_review_date, -> { order(review_date: :desc) }
  scope :sort_by_random, -> { order('RANDOM()') }
  scope :outdated, -> { where('review_date <= ?', Date.today) }

  def check_original_text_answer(answer)
    return false unless original_text.casecmp?(answer)
    reset_review_date
  end

  def reset_review_date
    set_review_date
    save!
  end

  private

  def text_difference
    return unless original_text.casecmp?(translated_text)
    errors.add(:translated_text, 'Оригинальный и переведенный текст не могут быть одинаковыми')
  end

  def set_review_date
    self.review_date = Date.today + 3.days
  end
end
