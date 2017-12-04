# frozen_string_literal: true

# Controller responsible for showing and creating cards
#
class CardsController < ApplicationController
  before_action :set_card, only: %i[check_original edit update destroy]

  def check_original
    if AnswerChecker.new(@card, params[:answer]).check_original_text
      redirect_to home_index_path, notice: 'Правильно!'
    else
      redirect_to home_index_path, alert: "Неверно! Правильный перевод: #{@card.original_text}"
    end
  end

  def index
    @cards = Card.all.sort_by_review_date
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path
    else
      render 'cards/new'
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render 'cards/edit'
    end
  end

  def destroy
    if @card.destroy
      redirect_to cards_url
    else
      redirect_to cards_url, alert: 'Произошла ошибка'
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end
