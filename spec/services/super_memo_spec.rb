require 'rails_helper'

RSpec.describe SuperMemo do
  let(:card) { create :card, original_text: 'Текст', review_date: Date.today }

  context '#days_offset' do
    let(:card_1_success) { create :card }
    let(:card_2_success) { create :card, success_count: 1 }

    it { expect(SuperMemo.new(card_1_success).days_offset).to eq(1) }
    it { expect(SuperMemo.new(card_2_success).days_offset).to eq(6) }

    context 'on 3rd and more correct answer' do
      let(:days_offset) { 6 }
      let(:e_factor) { 1.3 }
      let(:card_3_success) { create :card, success_count: 2, days_offset: days_offset, e_factor: e_factor }
      let(:super_memo) { SuperMemo.new(card_3_success) }

      it 'should calculate days offset' do
        allow(super_memo).to receive(:e_factor) { e_factor }
        expect(super_memo.days_offset).to eq(days_offset * e_factor)
      end
    end
  end

  context '#e_factor' do
    let(:card) { create :card, fail_count: 2, e_factor: 1.5 }
    let(:super_memo) { SuperMemo.new(card) }
    let(:expected_e_factor) { 1.36 }

    it { expect(super_memo.e_factor).to eq(expected_e_factor) }

    context "can't be lower than 1.3" do
      let(:card) { create :card, fail_count: 2, e_factor: 1.4 }
      let(:super_memo) { SuperMemo.new(card) }
      let(:expected_e_factor) { 1.3 }

      it { expect(super_memo.e_factor).to eq(expected_e_factor) }
    end
  end
end
