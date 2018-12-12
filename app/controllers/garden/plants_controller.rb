class Garden::PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :edit, :update, :destroy]

  def index
    @plants = current_user.plants
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user

    if @plant.save
      flash[:notice] = 'Your plant was successfully added to your garden.'
      redirect_to garden_plant_path(@plant)
    else
      flash.now[:alert] = 'Unable to add your plant'
      render :new
    end
  end

  private

  def plant_params
    params.require(:plant).permit(
      :name,
      :age_in_months,
      :size,
      :room,
      :photo_url
    )
  end

  def set_plant
    @plant = current_user.plants.find(params[:id])
  end
end
