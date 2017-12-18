# frozen_string_literal: true

# Welcomes user with root action index
#
class HomeController < ApplicationController
  def index
    return unless current_user
    @pack = current_user.current_pack
    @card = FindRandomCard.new(current_user, @pack).call
  end

  def locale
    redirect_to root_path(locale: params[:locale])
  end
end
