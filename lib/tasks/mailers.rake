# frozen_string_literal: true

namespace :mailers do
  desc "Sends mails to users with pending cards to review."
  task pending_cards: :environment do
    User.with_pending_cards.each do |user|
      CardsMailer.pending_cards_notification(user)
    end
  end

end
