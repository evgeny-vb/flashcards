# frozen_string_literal: true

# Model responsible for cards
#
class Card < ApplicationRecord
  belongs_to :pack

  has_attached_file :picture, styles: { original: '360x360>' }
  validates_attachment_content_type :picture, content_type: %r{\Aimage\/.*\z}

  validates :pack_id, :original_text, :translated_text, presence: true
  validates :success_count, :fail_count, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :review_date, presence: true, on: :update
  validate :text_difference

  scope :sort_by_review_date, -> { order(review_date: :desc) }
  scope :sort_by_random, -> { order('RANDOM()') }
  scope :outdated, -> { where('review_date <= ?', Time.now) }

  private

  def text_difference
    return unless original_text.casecmp?(translated_text)
    errors.add(:translated_text, 'Оригинальный и переведенный текст не могут быть одинаковыми')
  end
end
