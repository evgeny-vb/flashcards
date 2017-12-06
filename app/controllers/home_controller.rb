# frozen_string_literal: true

# Welcomes user with root action index
#
class HomeController < ApplicationController
  def index
    @card = current_user.cards.outdated.sort_by_random.first if current_user
  end
end
