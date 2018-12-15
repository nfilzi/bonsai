class UpdateUserPointsAndLevelService
  def initialize(user)
    @user = user
  end

  def call
    @user.care_points = recalculate_care_points
    @user.level       = recalculate_level

    @user.save
  end

  private

  def recalculate_care_points
    @user.plants.sum(:care_points)
  end

  def recalculate_level
    User::LEVELS.find { |level, range| range.include?(@user.care_points) }[0]
  end
end
