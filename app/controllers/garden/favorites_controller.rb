class Garden::FavoritesController < ApplicationController
  before_action :set_plant

  def create
    @plant.update(favorite: true)

    respond_to do |format|
      format.html { redirect_to garden_plant_path(@plant) }
      format.js { render :update_favorite_link }
    end
  end

  def destroy
    @plant.update(favorite: false)

    respond_to do |format|
      format.html { redirect_to garden_plant_path(@plant) }
      format.js { render :update_favorite_link }
    end
  end

  private

  def set_plant
    @plant = current_user.plants.find(params[:plant_id])
  end
end
