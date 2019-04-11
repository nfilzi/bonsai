require 'rails_helper'

RSpec.describe 'API - V1 - Plants', type: :request do

  describe 'GET /plants/:id' do
    context 'when the plant exists' do

      before :each do
        @owner = create(:users)
        @plant = create(:plants, owner: @owner, name: 'Fyro',  age_in_months: 3, size: 'small')

        get "/api/plants/#{@plant.id}", headers: { 'Accept' => 'application/json;version=1' }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns the plant' do
        plant = json_response['plants']

        expect(plant).not_to be_nil
      end

      it 'returns the plant with details' do
        plant = json_response['plants']

        expect(plant['name']).to          eq(@plant.name)
        expect(plant['age_in_months']).to eq(@plant.age_in_months)
        expect(plant['size']).to          eq(@plant.size)
      end
    end

    context 'when the plant does not exist' do
      let(:unexisting_plant_id) { Plant.last.id + 1 }

      before :each do
        create(:plants, :with_owner)

        get "/api/plants/#{unexisting_plant_id}", headers: { 'Accept' => 'application/json;version=1' }
      end

      it 'returns status code 404' do
        expect(response.status).to eq(404)
      end

      it 'returns JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Plant/)
      end
    end
  end
end
