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

  OFFSET_COLLECTION = [12.hours, 3.days, 1.week, 2.weeks, 1.month].freeze
  RESULT_CODES = { correct: 1, wrong: 2, typo: 3 }.freeze

  def check_original_text_answer(answer)
    if answer_correct?(answer)
      successful_attempt
      RESULT_CODES[:correct]
    elsif answer_typo?(answer)
      RESULT_CODES[:typo]
    else
      failed_attempt
      RESULT_CODES[:wrong]
    end
  end

  private

  def answer_correct?(answer)
    original_text.casecmp?(answer)
  end

  def answer_typo?(answer)
    LevenshteinDistance.calculate(original_text.downcase, answer.downcase) == 1
  end

  def successful_attempt
    self.review_date   = review_date_offset
    self.success_count += 1
    self.fail_count    = 0
    save!
  end

  def failed_attempt
    if fail_count == 2
      self.success_count = 0
      self.fail_count    = 0
      self.review_date   = review_date_offset
    else
      self.fail_count += 1
    end
    save!
  end

  def text_difference
    return unless original_text.casecmp?(translated_text)
    errors.add(:translated_text, 'Оригинальный и переведенный текст не могут быть одинаковыми')
  end

  def review_date_offset
    (OFFSET_COLLECTION[success_count] || OFFSET_COLLECTION.last).from_now
  end
end
