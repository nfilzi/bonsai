module Users
  class UpdateLevel
    def initialize(user)
      @user = user
    end

    def call
      @user.update(level: new_level_from_points)
    end

    private

    def new_level_from_points
      User::LEVELS.find { |level, range| range.include?(@user.care_points) }[0]
    end
  end
end
