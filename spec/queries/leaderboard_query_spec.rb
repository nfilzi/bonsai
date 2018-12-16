require 'rails_helper'

describe LeaderboardQuery, type: 'query' do
  subject(:query) { LeaderboardQuery.relation }

  describe '#ranking' do
    context 'when users have plants' do
      before :each do
        # 2nd user
        @user_2 = create(:user, nickname: 'Bob', care_points: 30, level: 2)
        plant = Plant.create!(user: @user_2, name: 'Robert')
        CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today)
        CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today - 3.days)
        CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today - 1.week)

        # 1st user
        @user_1 = create(:user, nickname: 'Janis', care_points: 122, level: 3)
        plant_1 = Plant.create!(user: @user_1, name: 'Jimy')
        plant_2 = Plant.create!(user: @user_1, name: 'Alanis')
        plant_3 = Plant.create!(user: @user_1, name: 'Jason')
        CareMoment.create!(plant: plant_1, code: 'repot', points: 100, date: Date.today)
        CareMoment.create!(plant: plant_1, code: 'water', points: 10, date: Date.today - 3.days)
        CareMoment.create!(plant: plant_2, code: 'water', points: 10, date: Date.today - 1.week)
        CareMoment.create!(plant: plant_3, code: 'weed', points: 2, date: Date.today - 1.week)

        # 4th user
        @user_4 = create(:user, nickname: 'Alice', care_points: 10, level: 1)
        plant = Plant.create!(user: @user_4, name: 'Daniel')
        CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today)

        # 3rd user
        @user_3 = create(:user, nickname: 'John', care_points: 12, level: 1)
        plant_1 = Plant.create!(user: @user_3, name: 'Adele')
        plant_2 = Plant.create!(user: @user_3, name: 'Line')
        CareMoment.create!(plant: plant_1, code: 'water', points: 10, date: Date.today)
        CareMoment.create!(plant: plant_2, code: 'weed', points: 2, date: Date.today)
      end

      it 'returns users ordered by top level and top care points' do
        expect(query.ranking).to eq([@user_1, @user_2, @user_3, @user_4])
      end

      it 'returns the number of plants each user has' do
        expect(query.ranking.map(&:plants_count)).to eq([3, 1, 2, 1])
      end

      it 'returns the number of care moments each user has' do
        expect(query.ranking.map(&:care_moments_count)).to eq([4, 3, 2, 1])
      end
    end

    context 'when users have no plant' do
      before :each do
        @no_plant_users = 2.times.map { create(:user) }
      end

      it 'still returns the users' do
        expect(query.ranking).to match_array(@no_plant_users)
      end

      it 'returns zero as the number of plants each user has' do
        expect(query.ranking.map(&:plants_count)).to eq([0, 0])
      end

      it 'returns zero as the number of care moments each user has' do
        expect(query.ranking.map(&:care_moments_count)).to eq([0, 0])
      end
    end
  end
end
