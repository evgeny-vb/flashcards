# frozen_string_literal: true

# Sends notifications about pending cards for review
#
class CardsMailer < ApplicationMailer
  default from: 'notifications@evgeny-flashcards.herokuapp.com'

  def pending_cards_notification(user)
    @user = user
    @url = 'https://evgeny-flashcards.herokuapp.com'
    mail(to: @user.email, subject: 'Пора повторить карточки!')
  end
end
