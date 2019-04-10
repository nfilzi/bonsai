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

  describe "validations" do
    it "validates name is present" do
      expect(plant).to validate_presence_of(:name)
    end
  end
end
