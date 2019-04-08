class LeaderboardController < ApplicationController
  def show
    @top_users = LeaderboardQuery.relation.execute
  end
end
