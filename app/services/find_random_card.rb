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
