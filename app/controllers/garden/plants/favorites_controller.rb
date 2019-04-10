module Garden
  module Plants
    class FavoritesController < ApplicationController
      def create
        @plant = current_user.plants.find(params[:plant_id])
        @plant.update(favorite: true)

        redirect_to garden_plant_path(@plant)
      end
    end
  end
end
