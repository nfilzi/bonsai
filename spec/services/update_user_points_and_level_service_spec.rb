require 'rails_helper'

describe UpdateUserPointsAndLevelService, type: 'service' do
  subject(:service) { UpdateUserPointsAndLevelService.new(user) }

  let(:user) { create(:user, care_points: 0) }

  let(:levels) do
    {
      0 => 0...15,
      1 => 15...50,
      2 => 50...120,
      3 => 100..Float::INFINITY
    }
  end

  describe '#call' do
    before :each do
      stub_const('User::LEVELS', levels)

      Plant.create!(user: user, name: 'Josh', care_points: 100)
      Plant.create!(user: user, name: 'Nathalia', care_points: 10)
    end

    it 'updates user care points based on his/her plants care points' do
      service.call
      expect(user.care_points).to eq(110)
    end

    it 'updates user level based on his/her care points' do
      service.call
      expect(user.level).to eq(2)
    end
  end
end
