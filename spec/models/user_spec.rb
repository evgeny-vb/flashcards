require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:pack) { create :pack, user: user }

  context '#update_current_pack' do
    it { expect { user.update_current_pack(pack) }.to change(user, :current_pack).from(nil).to(pack) }
  end
end
