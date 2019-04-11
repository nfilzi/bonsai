require 'rails_helper'

RSpec.describe "API - V1 - Plants", type: :request do

  describe "GET /plants" do
    before :each do
      create(:plants, :with_owner, name: 'Fyro',  age_in_months: 3, size: 'small')
      create(:plants, :with_owner, name: 'Zelda', age_in_months: 9, size: 'tall')

      get '/api/plants', headers: { 'Accept' => 'application/json;version=1' }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JSON' do
      expect(response.content_type).to eq("application/json")
    end

    it "returns plants" do
      plants = json_response["plants"]

      expect(json_response).not_to be_empty

      expect(plants.first["kind"]).to eq("Plant")
    end

    it 'returns the correct number of plants' do
      plants = json_response["plants"]

      expect(plants.count).to eq(2)
    end

    it "returns the plants details" do
      plants = json_response["plants"]

      first_plant  = plants.first
      second_plant = plants.last

      expect(first_plant["name"]).to           eq("Fyro")
      expect(first_plant["age_in_months"]).to  eq(3)
      expect(first_plant["size"]).to           eq('small')

      expect(second_plant["name"]).to          eq("Zelda")
      expect(second_plant["age_in_months"]).to eq(9)
      expect(second_plant["size"]).to          eq('tall')
    end
  end
end
