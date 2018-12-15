class LeaderboardQuery < BaseQuery
  def self.relation(base_relation=nil)
    super(base_relation, User)
  end

  def ranking
    select(
      <<~EOF
        users.*,
        count(distinct plants.id) AS plants_count,
        count(*) AS care_moments_count
      EOF
    ).
    left_outer_joins(plants: :care_moments).
    order('level DESC, care_points DESC').
    group('user_id')
  end
end
