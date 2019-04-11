require 'rails_helper'

RSpec.describe 'API - V1 - Plants', type: :request do
  describe 'POST /plants' do
    let(:user) { create(:users) }
    let(:headers) { valid_headers(user) }

    before :each do
      post '/api/plants', headers: headers, params: attributes
    end

    context 'when request is not valid' do
      let(:attributes) { { plant: { size: 'small' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when request is valid' do
      let(:attributes) do
        { plant: attributes_for(:plants).merge(id: 1, user_id: user.id) }
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'returns the plant with details' do
        plant = json_response['plants']

        plant_attributes = attributes[:plant]

        expect(plant['id']).to_not be_nil

        expect(plant['name']).to          eq(plant_attributes[:name])
        expect(plant['age_in_months']).to eq(plant_attributes[:age_in_months])
        expect(plant['size']).to          eq(plant_attributes[:size])
      end
    end
  end
end
