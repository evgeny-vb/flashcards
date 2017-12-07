# frozen_string_literal: true

# Responsible for creating new user
#
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login @user
      redirect_to root_path, notice: 'Регистрация успешна!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Успешно отредактировано!'
    else
      render 'users/edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
