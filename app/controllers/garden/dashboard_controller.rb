module Garden
  class DashboardController < ApplicationController
    def show
      @user = UserPresenter.new(current_user)

      @last_level = User::LEVELS.keys.last

      @latest_plants       = current_user.plants.order("created_at DESC").limit(3)
      @plants_needing_care = PlantPresenter.wrap(current_user.plants.needing_care)
    end
  end
end
