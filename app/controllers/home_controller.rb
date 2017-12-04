# frozen_string_literal: true

# Welcomes user with root action index
#
class HomeController < ApplicationController
  def index
    @card = Card.outdated.sort_by_random.first
  end
end
