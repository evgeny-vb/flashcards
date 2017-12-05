require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { create :card, original_text: 'Текст', review_date: Date.today }

  context '#reset_review_date' do
    let(:expected_review_date) { 3.days.from_now.to_date }

    it 'sets review_date by 3 days from today' do
      card.reset_review_date!
      expect(card.reload.review_date).to eq(expected_review_date)
    end
  end

  context '#check_original_text_answer' do
    context 'compares original_text with passed answer' do
      context 'when answer is correct' do
        let(:correct_answers) { %w[Текст текст текСТ] }
        it 'should return true' do
          correct_answers.each do |answ|
            expect(card.check_original_text_answer(answ)).to be true
          end
        end
      end

      context 'when answer is incorrect' do
        let(:incorrect_answers) { %w[Тексд екст] }
        it 'should return false' do
          incorrect_answers.each do |answ|
            expect(card.check_original_text_answer(answ)).to be false
          end
        end
      end
    end
  end
end
