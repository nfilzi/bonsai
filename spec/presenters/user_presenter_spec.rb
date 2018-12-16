require 'rails_helper'

describe UserPresenter, type: 'presenter' do
  subject(:presenter) { UserPresenter.new(user) }

  let(:user) { User.new(nickname: 'Bob') }

  describe '#points_to_next_level' do
    before :each do
      allow(User::LEVELS).to receive(:[]).with(2).and_return(15...30)

      user.care_points = 12
      user.level       = 1
    end

    it 'returns number of points needed to jump to next level' do
      expect(presenter.points_to_next_level).to eq(3)
    end
  end
end
