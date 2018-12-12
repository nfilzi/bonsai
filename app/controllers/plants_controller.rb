class PlantsController < ApplicationController
  def index
    @plants = Plant.order("created_at DESC")
  end

  def show
    @plant = Plant.find(params[:id])

    @gardener_other_plants = Plant.select do |plant|
      plant != @plant && plant.user == @plant.user
    end
  end
end
