class LeaderboardQuery < BaseQuery
  base_model User

  def execute
    select(
      "users.*,
      COUNT(DISTINCT plants.id) AS plants_count,
      COUNT(*)                  AS care_moments_count"
    ).
    left_outer_joins(:plants, :care_moments).
    order('level DESC, users.care_points DESC').
    group("users.id").
    limit(10)
  end
end
