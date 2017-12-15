# frozen_string_literal: true

## ApplicationController
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = current_user&.locale || params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
