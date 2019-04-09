module Users
  class UpdateCarePoints
    def initialize(user)
      @user = user
    end

    def call
      @user.update(care_points: @user.care_moments.sum(:points))
    end
  end
end
