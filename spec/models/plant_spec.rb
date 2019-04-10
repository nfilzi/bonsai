require 'rails_helper'

RSpec.describe Plant, type: :model do
  subject(:plant) do
    build(:plants)
  end

  describe "associations" do
    it "has an owner" do
      expect(plant).to belong_to(:owner)
    end

    it "receives many care moments" do
      expect(plant).to have_many(:care_moments)
    end
  end


  describe "scopes" do
    describe ".needing_care" do
      before :each do
        @plants_needing_care = create_list(:plants, 2, :with_owner)

        care_moments = [
          CareMoment.new(code: :water, points: 10,  date: Date.today),
          CareMoment.new(code: :repot, points: 100, date: Date.today),
          CareMoment.new(code: :weed,  points: 20,  date: Date.today)
        ]

        @plant_not_needing_care = create(:plants, :with_owner, care_moments: care_moments)
      end

      it "returns only plants which need care from their owners" do
        expect(Plant.needing_care).to match_array(@plants_needing_care)
      end
    end

    describe ".include_care_status" do
      before :each do
        care_moments = [
          CareMoment.new(code: :water, points: 10,  date: Date.today),
          CareMoment.new(code: :repot, points: 100, date: Date.today)
        ]

        @plant_not_needing_care = create(:plants, :with_owner, care_moments: care_moments)
      end

      it "returns plants enhanced with their care status" do
        plant = Plant.include_care_status.first

        expect(plant.weed_needed).to eq(1)
        expect(plant.water_needed).to eq(0)
        expect(plant.repot_needed).to eq(0)
      end
    end
  end

  describe "validations" do
    it "validates name is present" do
      expect(plant).to validate_presence_of(:name)
    end
  end
end
