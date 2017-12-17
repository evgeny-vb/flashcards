# frozen_string_literal: true

## SuperMemo-2 Algorithm for calculation of the next review date
#
class SuperMemo
  attr_reader :card

  def initialize(card)
    @card = card
  end

  def days_offset
    @days_offset ||=
      case card.success_count
      when 0 then 1
      when 1 then 6
      else card.days_offset * e_factor
      end
  end

  def e_factor
    @e_factor ||= calculate_e_factor
  end

  def new_review_date
    days_offset.days.from_now
  end

  private

  def calculate_e_factor
    ef = card.e_factor + (0.1 - card.fail_count * (0.08 + card.fail_count * 0.02))
    ef = 1.3 if ef < 1.3
    ef
  end
end
