# frozen_string_literal: true

# Controller responsible for packs of cards
#
class PacksController < ApplicationController
  before_action :set_pack, only: %i[set_as_current show edit update destroy]
  before_action :require_login

  def set_as_current
    if current_user.update_current_pack(@pack)
      redirect_to packs_path
    else
      redirect_to packs_path, alert: 'Ошибка'
    end
  end

  def index
    @packs = current_user.packs
  end

  def show
    @cards = @pack.cards.sort_by_review_date
  end

  def new
    @pack = Pack.new
  end

  def create
    @pack = current_user.packs.new(pack_params)

    if @pack.save
      redirect_to packs_path
    else
      render 'packs/new'
    end
  end

  def edit; end

  def update
    if @pack.update(pack_params)
      redirect_to packs_path
    else
      render 'packs/edit'
    end
  end

  def destroy
    if @pack.destroy
      redirect_to packs_url
    else
      redirect_to packs_url, alert: 'Произошла ошибка'
    end
  end

  private

  def set_pack
    @pack = current_user.packs.find(params[:id])
  end

  def pack_params
    params.require(:pack).permit(:name)
  end
end
