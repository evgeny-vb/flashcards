# frozen_string_literal: true

## Service for getting random card from pack or from all user cards
#
class FindRandomCard
  def initialize(user, pack)
    @user = user
    @pack = pack
  end

  def call
    if @pack
      @pack.cards.outdated.sort_by_random.first
    else
      @user.cards.outdated.sort_by_random.first
    end
  end
end
