# frozen_string_literal: true

# Class used to compare card text with user entered text
#
class AnswerChecker
  attr_reader :card, :answer

  def initialize(card, answer)
    @card   = card
    @answer = answer
  end

  def check_original_text
    return false unless card.original_text.casecmp?(answer)
    card.reset_review_date
  end
end
