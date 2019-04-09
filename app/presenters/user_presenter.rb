require 'delegate'

class UserPresenter < SimpleDelegator
  attr_reader :user

  def initialize(user)
    @user = user
    super
  end

  def points_to_next_level
    next_level = User::LEVELS[level + 1]
    return 0 unless next_level

    next_level.min - care_points
  end
end
