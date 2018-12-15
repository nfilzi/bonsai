class LeaderboardController < ApplicationController
  def show
    @top_users = LeaderboardQuery.relation.ranking.limit(10)
  end
end
