require 'rails_helper'

describe UpdatePlantCarePointsService, type: 'service' do
  subject(:service) { UpdatePlantCarePointsService.new(plant) }

  let(:plant) { Plant.create!(user: create(:user), name: 'Elvis', care_points: 0) }

  describe '#call' do
    before :each do
      CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today)
      CareMoment.create!(plant: plant, code: 'weed', points: 2, date: Date.today)
    end

    it 'updates plant care points based on its care moment points' do
      service.call
      expect(plant.care_points).to eq(12)
    end
  end
end
