class LeaderboardController < ApplicationController
  def show
    @top_users = LeaderboardQuery.relation.execute.limit(10)
    @top_users = Users::LeaderboardPresenter.wrap(@top_users)
  end
end
