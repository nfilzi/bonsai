class LeaderboardController < ApplicationController
  def show
    @top_users = User.order('level DESC, care_points DESC').limit(10)
  end
end
