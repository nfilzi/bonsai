class Garden::DashboardController < ApplicationController
  def show
    @last_level = User::LEVELS.keys.last

    user_plants          = current_user.plants
    @latest_plants       = user_plants.order("created_at DESC").limit(3)
    @plants_needing_care = PlantQuery.relation(user_plants).needing_care.order(:name)
  end
end
