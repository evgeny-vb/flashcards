require 'rails_helper'

RSpec.describe Pack, type: :model do
  let(:user) { create :user }
  let(:pack) { create :pack, user: user }

  context '#mark_as_current_for_user' do
    before do
      3.times { create :pack, user: user }
      create :pack, user: user, current: true
    end

    it 'current pack count should be 1' do
      expect { pack.mark_as_current_for_user }.not_to change(Pack.current, :count)
    end

    it 'sets pack as current' do
      expect { pack.mark_as_current_for_user }.to change(pack, :current).to true
    end
  end
end
