require 'rails_helper'

RSpec.describe "API - V1 - Plants", type: :request do

  describe "gets details of a plant" do

    before :each do
      @owner = create(:users)
      @plant = create(:plants, owner: @owner, name: 'Fyro',  age_in_months: 3, size: 'small')
    end

    context "without its owner details" do
      it "works" do
        get "/api/plants/#{@plant.id}", headers: { 'Accept' => 'application/json;version=1' }

        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        plant = json_response["plants"]

        expect(plant["name"]).to eq("Fyro")
        expect(plant["age_in_months"]).to eq(3)
        expect(plant["size"]).to eq('small')
      end
    end

    context "with its owner details" do
      it "works" do
        get "/api/plants/#{@plant.id}?with_owner=true", headers: { 'Accept' => 'application/json;version=1' }

        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        plant         = json_response["plants"]
        owner_details = plant["owner"]

        expect(owner_details["nickname"]).to    eq(@owner.nickname)
        expect(owner_details["level"]).to       eq(@owner.level)
        expect(owner_details["care_points"]).to eq(@owner.care_points)
      end
    end
  end
end
