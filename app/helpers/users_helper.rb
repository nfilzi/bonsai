module UsersHelper
  def user_rank_medal(rank)
    case rank
    when 1 then '🥇'
    when 2 then '🥈'
    when 3 then '🥉'
    else '🏅'
    end
  end
end
