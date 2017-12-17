require 'rails_helper'

RSpec.describe AnswerChecker do
  let(:card) { create :card, original_text: 'Текст', review_date: Date.today }
  let(:review_offset) { be_within(1.second).of 1.day.from_now }

  context '#check_original_text_answer' do
    context 'compares original_text with passed answer' do
      context 'when answer is correct' do
        let(:answer) { 'Текст' }
        let(:correct_answers) { %w[Текст текст текСТ] }

        it 'should return correct_code' do
          correct_answers.each do |answ|
            expect(AnswerChecker.new(card, answ).check_original_text_answer)
              .to be AnswerChecker::RESULT_CODES[:correct]
          end
        end

        it 'increases success_count' do
          expect { AnswerChecker.new(card, answer).check_original_text_answer }
            .to change(card, :success_count).by(1)
        end

        it 'updates review_date' do
          expect { AnswerChecker.new(card, answer).check_original_text_answer }
            .to change(card, :review_date).to review_offset
        end
      end

      context 'when typo in answer' do
        let(:incorrect_answers) { %w[Тексд екст] }

        it 'should return wrong_code' do
          incorrect_answers.each do |answ|
            expect(AnswerChecker.new(card, answ).check_original_text_answer)
              .to be AnswerChecker::RESULT_CODES[:typo]
          end
        end
      end

      context 'when answer is incorrect' do
        let(:answer) { 'Текзд' }
        let(:incorrect_answers) { %w[Текзд егст] }

        it 'should return wrong_code' do
          incorrect_answers.each do |answ|
            expect(AnswerChecker.new(card, answ).check_original_text_answer)
              .to be AnswerChecker::RESULT_CODES[:wrong]
          end
        end

        it 'increases fail_count' do
          expect { AnswerChecker.new(card, answer).check_original_text_answer }
            .to change(card, :fail_count).by(1)
        end

        context 'on 3rd fail' do
          before { card.update(fail_count: 2, success_count: 2) }
          it 'resets success_count and review_date' do
            expect { AnswerChecker.new(card, answer).check_original_text_answer }
              .to change(card, :success_count).to(0)
                    .and change(card, :review_date).to review_offset
          end
        end
      end
    end
  end
end
