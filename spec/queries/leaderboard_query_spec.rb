require 'rails_helper'

RSpec.describe LeaderboardQuery, type: :query do
  subject(:leaderboard_query) do
    LeaderboardQuery
  end

  describe ".execute" do
    before :each do
      user_2 = create(:users, level: 5, care_points: 1700)
      user_1 = create(:users, level: 6, care_points: 1991)
      user_4 = create(:users, level: 3, care_points: 200)
      user_3 = create(:users, level: 4, care_points: 1300)
      user_5 = create(:users, level: 2, care_points: 20)

      @top_users = [user_1, user_2, user_3, user_4, user_5]
    end

    it "returns top users" do
      expect(leaderboard_query.relation.execute).to match_array(@top_users)
    end
  end
end
