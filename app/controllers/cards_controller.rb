# frozen_string_literal: true

# Controller responsible for showing and creating cards
#
class CardsController < ApplicationController
  def index
    @cards = Card.all
  end
end
