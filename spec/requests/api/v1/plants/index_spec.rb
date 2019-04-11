require 'rails_helper'

RSpec.describe "API - V1 - Plants", type: :request do

  describe "gets a list of plants" do
    before :each do
      # TODO: debug Rack::Test::Methods
      # header 'Accept', 'application/json;version=1'

      create(:plants, :with_owner, name: 'Fyro',  age_in_months: 3, size: 'small')
      create(:plants, :with_owner, name: 'Zelda', age_in_months: 9, size: 'tall')
    end

    it "lists all plants" do
      get '/api/plants', headers: { 'Accept' => 'application/json;version=1' }

      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      json_response = JSON.parse(response.body)

      plants       = json_response["plants"]
      first_plant  = plants.first
      second_plant = plants[1]

      expect(plants.count).to eq(2)

      expect(first_plant["name"]).to eq("Fyro")
      expect(first_plant["age_in_months"]).to eq(3)
      expect(first_plant["size"]).to eq('small')

      expect(second_plant["name"]).to eq("Zelda")
      expect(second_plant["age_in_months"]).to eq(9)
      expect(second_plant["size"]).to eq('tall')
    end
  end
end
