# frozen_string_literal: true

# Controller responsible for showing and creating cards
#
class CardsController < ApplicationController
  before_action :set_card, only: %i[check_original_text edit update destroy]
  before_action :set_pack, only: %i[new create destroy]
  before_action :require_login

  def check_original_text
    if @card.check_original_text_answer(params[:answer])
      redirect_to home_index_path, notice: 'Правильно!'
    else
      redirect_to home_index_path, alert: "Неверно! Правильный перевод: #{@card.original_text}"
    end
  end

  def new
    @card = Card.new
  end

  def create
    @card = @pack.cards.new(card_params)

    if @card.save
      redirect_to @pack
    else
      render 'cards/new'
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to @card.pack
    else
      render 'cards/edit'
    end
  end

  def destroy
    if @card.destroy
      redirect_to @pack
    else
      redirect_to @pack, alert: 'Произошла ошибка'
    end
  end

  private

  def set_pack
    @pack = current_user.packs.find(params[:pack_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :picture)
  end
end
