require 'rails_helper'

RSpec.describe Users::UpdateCarePoints, type: :service do
  subject(:service) do
    Users::UpdateCarePoints.new(user)
  end

  let(:user) { create(:users, care_points: 100) }

  before :each do
    plant = create(:plants, owner: user)
    create_list(:care_moments, 3, points: 100, plant: plant)
  end

  describe "#call" do
    it "udpates a user care points" do
      service.call
      user.reload

      expect(user.care_points).to eq(300)
    end
  end
end
