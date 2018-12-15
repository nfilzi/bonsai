class LeaderboardQuery < BaseQuery
  def self.relation(base_relation=nil)
    super(base_relation, User)
  end

  def ranking
    select(
      <<~EOF
        users.*,
        count(distinct plants.id) AS plants_count,
        count(care_moments.id) AS care_moments_count
      EOF
    ).
    left_outer_joins(plants: :care_moments).
    order('level DESC, care_points DESC').
    group('users.id')
  end
end
