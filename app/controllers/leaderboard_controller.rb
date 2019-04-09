class LeaderboardController < ApplicationController
  def show
    @top_users = LeaderboardQuery.relation.execute
    @top_users = Users::LeaderboardPresenter.wrap(@top_users)
  end
end
