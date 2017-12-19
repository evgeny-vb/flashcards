# frozen_string_literal: true

## Service for getting random card from pack or from all user cards
#
module FindRandomCard
  module_function

  def call(user, pack = nil)
    (pack || user).cards.outdated.sort_by_random.first
  end
end
