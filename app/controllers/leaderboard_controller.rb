class LeaderboardController < ApplicationController
  def show
    @top_users = User.leaderboard.limit(10)
  end
end
