class PlantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @plants = Plant.eager_load(:owner).order("plants.created_at DESC")
  end

  def show
    @plant = Plant.find(params[:id])

    @gardener_other_plants = @plant.owner.plants.
      where.not(id: @plant.id).
      eager_load(:owner)
  end
end
