class PlantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @plants = Plant.eager_load(:owner).order("plants.created_at DESC")
  end

  def show
    @plant = Plant.find(params[:id])

    @gardener_other_plants = Plant.where.not(owner: current_user).eager_load(:owner)
  end
end
