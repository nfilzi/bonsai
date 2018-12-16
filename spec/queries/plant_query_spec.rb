require 'rails_helper'

describe PlantQuery, type: 'query' do
  subject(:query) { PlantQuery.relation }

  before :each do
    @plant_not_needing_care = Plant.create!(user: create(:user), name: 'Austin Powers')
    CareMoment.create(plant: @plant_not_needing_care, code: 'water', points: 10, date: Date.today)
    CareMoment.create(plant: @plant_not_needing_care, code: 'weed', points: 2, date: Date.today)
    CareMoment.create(plant: @plant_not_needing_care, code: 'repot', points: 100, date: Date.today)

    @plants_needing_care = [
      Plant.create!(user: create(:user), name: 'Weaky'),  # a bit of care
      Plant.create!(user: create(:user), name: 'Thirsty') # no care at all (yet)
    ]
    CareMoment.create!(plant: @plants_needing_care.first, code: 'water', points: 10, date: Date.today)
    CareMoment.create!(plant: @plants_needing_care.first, code: 'weed', points: 2, date: Date.today)
  end

  describe '#include_care_status' do
    it 'returns care status for each type of care moment' do
      result = PlantQuery.relation.include_care_status.find(@plants_needing_care.first.id)

      expect(result.water_needed).to eq(0)
      expect(result.weed_needed).to  eq(0)
      expect(result.repot_needed).to eq(1)
    end
  end

  describe '#needing_care' do
    it 'returns only plants needing care' do
      expect(query.needing_care).to match_array(@plants_needing_care)
    end

    it 'returns care status of each plant that needs care' do
      results = query.needing_care.order(:id)

      actual_water_needed = results.map(&:water_needed)
      actual_weed_needed  = results.map(&:weed_needed)
      actual_repot_needed = results.map(&:repot_needed)

      expect(actual_water_needed).to eq([0, 1])
      expect(actual_weed_needed).to  eq([0, 1])
      expect(actual_repot_needed).to eq([1, 1])
    end
  end
end
