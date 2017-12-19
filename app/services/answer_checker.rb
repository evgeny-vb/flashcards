# frozen_string_literal: true

## Service responsible for processing user answers
#
class AnswerChecker
  attr_reader :card, :answer

  RESULT_CODES = { correct: 1, wrong: 2, typo: 3 }.freeze

  def initialize(card, answer)
    @card   = card
    @answer = answer
  end

  def result_message
    case check_original_text_answer
    when RESULT_CODES[:correct]
      'Правильно!'
    when RESULT_CODES[:typo]
      "Неверно! Возможно вы допустили опечатку.
        Правильный перевод: #{card.original_text}. Вы ввели: #{answer}"
    when RESULT_CODES[:wrong]
      "Неверно! Правильный перевод: #{card.original_text}"
    end
  end

  def check_original_text_answer
    if answer_correct?
      successful_attempt
      RESULT_CODES[:correct]
    elsif answer_typo?
      RESULT_CODES[:typo]
    else
      failed_attempt
      RESULT_CODES[:wrong]
    end
  end

  private

  def answer_correct?
    card.original_text.casecmp?(answer)
  end

  def answer_typo?
    Levenshtein.distance(card.original_text.downcase, answer.downcase) == 1
  end

  def successful_attempt
    update_review_date(true)
    card.fail_count    = 0
    card.success_count += 1
    card.save!
  end

  def failed_attempt
    if card.fail_count == 2
      card.success_count = 0
      card.fail_count    = 0
      update_review_date
    else
      card.fail_count += 1
    end
    card.save!
  end

  def update_review_date(success = false)
    sm               = SuperMemo.new(card)
    card.days_offset = sm.days_offset
    card.e_factor    = sm.e_factor if success
    card.review_date = sm.new_review_date
  end
end
