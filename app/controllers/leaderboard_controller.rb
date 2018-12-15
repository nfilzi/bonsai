class LeaderboardController < ApplicationController
  def show
    @top_users = User.select(
        <<~EOF
          users.*,
          count(distinct plants.id) AS plants_count,
          count(*) AS care_moments_count
        EOF
      ).
      left_outer_joins(plants: :care_moments).
      order('level DESC, care_points DESC').
      group('user_id').
      limit(10)
  end
end
