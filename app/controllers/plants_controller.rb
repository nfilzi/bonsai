class PlantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @plants = Plant.eager_load(:user).order("plants.created_at DESC")
  end

  def show
    @plant = Plant.find(params[:id])

    @gardener_other_plants = Plant.select do |plant|
      plant != @plant && plant.user == @plant.user
    end
  end
end
