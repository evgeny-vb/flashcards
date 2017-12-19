require 'rails_helper'

RSpec.describe 'Pack', type: :feature do
  let(:user) { create :user }
  let(:pack) { create :pack, user: user }

  before do
    login(user.email, '123456')
    visit root_path
  end

  context '/packs' do
    let(:user_pack_count) { 2 }
    before do
      3.times { create :pack }
      user_pack_count.times { create :pack, user: user }
      visit packs_path
    end
    it 'shows packs only for current_user' do
      expect(page).to have_selector('.rspec-pack', count: user_pack_count)
    end
  end

  context '/show' do
    let(:pack_cards_count) { 4 }
    before do
      3.times { create :card }
      pack_cards_count.times { create :card, pack: pack }
      visit pack_path(pack)
    end

    it 'have link to create card' do
      expect(page).to have_selector('#add-card')
    end

    it 'shows cards only for this pack' do
      expect(page).to have_selector('.rspec-card', count: pack_cards_count)
    end
  end
end
