require 'rails_helper'

RSpec.describe LeaderboardQuery, type: :query do
  subject(:leaderboard_query) do
    LeaderboardQuery
  end

  describe ".execute" do
    before :each do
      @top_10_users = []

      @top_10_users << create(:users, level: 6, care_points: 1991)
      @top_10_users << create(:users, level: 5, care_points: 1700)
      @top_10_users << create(:users, level: 5, care_points: 1520)
      @top_10_users << create(:users, level: 4, care_points: 1300)
      @top_10_users << create(:users, level: 4, care_points: 1100)
      @top_10_users << create(:users, level: 3, care_points: 400)
      @top_10_users << create(:users, level: 3, care_points: 399)
      @top_10_users << create(:users, level: 3, care_points: 320)
      @top_10_users << create(:users, level: 3, care_points: 200)
      @top_10_users << create(:users, level: 2, care_points: 20)

      create(:users, level: 1, care_points: 15)
      create(:users, level: 0, care_points: 9)
    end

    it "returns 10 users exactly" do
      expect(leaderboard_query.relation.execute.to_a.count).to eq(10)
    end

    it "returns top 10 users" do
      expect(leaderboard_query.relation.execute).to eq(@top_10_users)
    end
  end
end
