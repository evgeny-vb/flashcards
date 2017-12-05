require 'rails_helper'

RSpec.describe 'Checking translation' do
  let(:original_text) { 'Текст' }
  let!(:card) { create :card, original_text: original_text, review_date: Date.today }

  before { visit '/' }

  it 'should have translated text' do
    expect(page).to have_content card.translated_text
  end

  it 'should show answer form' do
    expect(page).to have_css '.spec-answer-form'
  end

  context 'fill correct answer and submit' do
    before do
      fill_in 'answer', with: original_text
      click_button 'Проверить'
    end

    it 'should show success message' do
      expect(page).to have_content 'Правильно!'
    end
  end

  context 'fill incorrect answer and submit' do
    before do
      fill_in 'answer', with: 'incorrect'
      click_button 'Проверить'
    end

    it 'should show success message' do
      expect(page).to have_content 'Неверно!'
    end
  end
end
