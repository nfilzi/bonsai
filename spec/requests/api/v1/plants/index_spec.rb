require 'rails_helper'

RSpec.describe "API - V1 - Plants", type: :request do

  describe "GET /plants" do
    before :each do
      create(:plants, :with_owner, :reindex, name: 'Fyro',  age_in_months: 3, size: 'small')
      create(:plants, :with_owner, :reindex, name: 'Zelda', age_in_months: 9, size: 'tall')

      get '/api/plants', headers: api_headers
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

  describe "GET /plants with search", search: true do
    context 'based on a query' do
      context 'with the plant name' do
        let(:plants_names) { %w(Tim Timo Timothée) }
        let(:query)        { plants_names.first }
        let(:params)       { { query: query } }

        before do
          @plants_candidates = plants_names.map do |plant_name|
            create(:plants, :with_owner, :reindex, name: plant_name)
          end

          create(:plants, :with_owner, :reindex)

          get "/api/plants", params: params, headers: api_headers
        end

        it 'returns only plants matching the query' do
          expect(response).to              have_http_status(200)
          expect(response.content_type).to eq("application/json")

          plants_ids = json_response["plants"].map { |plant| plant['id'] }

          expect(plants_ids).to match_array(@plants_candidates.map(&:id))
        end
      end

      context 'with the plant name & the owner name' do
        let(:reference_plant_data) { { name: 'Tim',  owner_nickname: 'nico' } }
        let(:other_plants_data) {
          [
            {name: 'Timo', owner_nickname: 'nicolas'},
            {name: 'Tom',  owner_nickname: 'nick'}
          ]
        }

        let(:all_plants_data) { other_plants_data << reference_plant_data }

        let(:query)  { "#{reference_plant_data[:name]} #{reference_plant_data[:owner_nickname]}" }
        let(:params) { { query: query } }

        before do
          @plants_candidates = all_plants_data.map do |name:, owner_nickname:|
            user = create(:users, nickname: owner_nickname)

            create(:plants, :reindex, owner: user, name: name)
          end

          create(:plants, :with_owner, :reindex)

          get "/api/plants", params: params, headers: api_headers
        end

        it 'returns only plants matching the query' do
          expect(response).to              have_http_status(200)
          expect(response.content_type).to eq("application/json")

          plants_ids = json_response["plants"].map { |plant| plant['id'] }

          expect(plants_ids).to match_array(@plants_candidates.map(&:id))
        end
      end
    end

    context 'based on their size' do
      let(:target_size) { 'small' }
      let(:other_size)  { 'tall' }
      let(:params)      { { size: target_size } }

      before do
        @target_plants = create_list(:plants, 3, :with_owner, :reindex, size: target_size)

        create(:plants, :with_owner, :reindex, size: other_size)

        get "/api/plants", params: params, headers: api_headers
      end

      it 'returns only plants of chosen size' do
        expect(response).to              have_http_status(200)
        expect(response.content_type).to eq("application/json")

        plants_ids = json_response["plants"].map { |plant| plant['id'] }

        expect(plants_ids).to match_array(@target_plants.map(&:id))
      end
    end

    context 'based on their room' do
      let(:target_room) { 'living-room' }
      let(:other_room)  { 'bedroom' }
      let(:params)      { { room: target_room } }

      before do
        @target_plants = create_list(:plants, 3, :with_owner, :reindex, room: target_room)

        create(:plants, :with_owner, room: other_room)

        get "/api/plants", params: params, headers: api_headers
      end

      it 'returns only plants in chosen room type' do
        expect(response).to              have_http_status(200)
        expect(response.content_type).to eq("application/json")

        plants_ids = json_response["plants"].map { |plant| plant['id'] }

        expect(plants_ids).to match_array(@target_plants.map(&:id))
      end
    end
  end
end
