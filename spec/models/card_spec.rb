require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { create :card, original_text: 'Текст', review_date: Date.today }
  let(:review_offset) { be_within(1.second).of 12.hours.from_now }

  context '#review_date_offset' do
    context 'returns DateTime depending on success_count' do
      it 'when 0 should be 12 hours from now' do
        expect(card.send(:review_date_offset)).to review_offset
      end
    end
  end

  context '#check_original_text_answer' do
    context 'compares original_text with passed answer' do
      context 'when answer is correct' do
        let(:answer) { 'Текст' }
        let(:correct_answers) { %w[Текст текст текСТ] }
        it 'should return true' do
          correct_answers.each do |answ|
            expect(card.check_original_text_answer(answ)).to be true
          end
        end

        it 'increases success_count' do
          expect { card.check_original_text_answer(answer) }
            .to change(card, :success_count).by(1)
        end

        it 'updates review_date' do
          expect { card.check_original_text_answer(answer) }
            .to change(card, :review_date).to review_offset
        end
      end

      context 'when answer is incorrect' do
        let(:answer) { 'Тексд' }
        let(:incorrect_answers) { %w[Тексд екст] }
        it 'should return false' do
          incorrect_answers.each do |answ|
            expect(card.check_original_text_answer(answ)).to be false
          end
        end

        it 'increases fail_count' do
          expect { card.check_original_text_answer(answer) }
            .to change(card, :fail_count).by(1)
        end

        context 'on 3rd fail' do
          before { card.update(fail_count: 2, success_count: 2) }
          it 'resets success_count and review_date' do
            expect { card.check_original_text_answer(answer) }
              .to change(card, :success_count).to(0)
                .and change(card, :review_date).to review_offset
          end
        end
      end
    end
  end
end
