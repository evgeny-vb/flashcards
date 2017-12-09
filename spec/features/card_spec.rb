require 'rails_helper'

RSpec.describe 'Card' do
  let(:original_text) { 'Текст' }
  let(:user) { create :user }
  let(:pack) { create :pack, user: user }
  let!(:card) { create :card, original_text: original_text, review_date: Date.today, pack: pack }

  before do
    login(user.email, '123456')
    visit root_path
  end

  context 'upload image' do
    before { visit edit_card_url(card) }

    it 'can upload image' do
      attach_file 'card_picture', 'spec/uploaders/files/image.jpg'
      click_button 'Сохранить карточку'
      expect(card.picture).not_to be_nil
    end
  end

  context 'checking translation' do
    it 'should have translated text' do
      expect(page).to have_content card.translated_text
    end

    it 'should show answer form' do
      expect(page).to have_css '.spec-answer-form'
    end

    context 'fill correct answer and submit' do
      it 'should show success message' do
        fill_in 'answer', with: original_text
        click_button 'Проверить'
        expect(page).to have_content 'Правильно!'
      end
    end

    context 'fill incorrect answer and submit' do
      it 'should show success message' do
        fill_in 'answer', with: 'incorrect'
        click_button 'Проверить'
        expect(page).to have_content 'Неверно!'
      end
    end
  end
end
