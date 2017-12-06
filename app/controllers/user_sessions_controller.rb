# frozen_string_literal: true

# Responsible for sessions
#
class UserSessionsController < ApplicationController
  def new; end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, notice: 'Вы успешно вошли!'
    else
      flash.now[:alert] = 'Ошибка'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Вы вышли из системы'
  end
end
