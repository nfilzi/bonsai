require 'rails_helper'

describe CreateCareMomentService, type: 'service' do
  subject(:service) { CreateCareMomentService.new(plant, code) }

  let(:code) { 'water' }

  let(:levels) do
    {
      0 => 0...15,
      1 => 15...50,
      2 => 50...120,
      3 => 100..Float::INFINITY
    }
  end

  let(:moments) do
    {
      water: {
        points: 5,
        min_frequency_in_days: 3
      },
      repot: {
        points: 30,
        min_frequency_in_days: 300
      }
    }
  end

  let(:plant) do
    Plant.create!(
      user: user,
      name: 'Bag',
      care_points: 10,
      care_moments: [
        CareMoment.new(code: 'water', points: 5, date: Date.today - 1.week),
        CareMoment.new(code: 'water', points: 5, date: Date.today - 3.week)
      ]
    )
  end

  let(:user) { create(:user, care_points: 10, level: 0) }

  before :each do
    stub_const('CareMoment', CareMoment)
    stub_const('CareMoment::MOMENTS', moments)
    stub_const('User::LEVELS', levels)
  end

  describe '#call' do
    it 'creates a care moment for the plant' do
      expect { service.call }.to change { plant.care_moments.count }.by(1)
    end

    it 'returns true' do
      expect(service.call).to eq(true)
    end

    it 'updates plant care points' do
      service.call
      expect(plant.care_points).to eq(15)
    end

    it 'updates user care points' do
      service.call
      expect(user.care_points).to eq(15)
    end

    it 'updates user level' do
      service.call
      expect(user.level).to eq(1)
    end

    describe 'created care moment' do
      let(:created_care_moment) do
        service.call
        CareMoment.last
      end

      it 'has a code' do
        expect(created_care_moment.code).to eq('water')
      end

      it 'has a date' do
        expect(created_care_moment.date).to eq(Date.today)
      end

      it 'has points' do
        expect(created_care_moment.points).to eq(5)
      end
    end
  end
end
