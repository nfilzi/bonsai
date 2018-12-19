class Garden::FavoritesController < ApplicationController
  before_action :set_plant

  def create
    @plant.update(favorite: true)
    render_plant
  end

  def destroy
    @plant.update(favorite: false)
    render_plant
  end

  private

  def render_plant
    respond_to do |format|
      format.html { redirect_to garden_plant_path(@plant) }

      format.json do
        partial = render_to_string(
          partial: '/garden/plants/favorite_link',
          locals:  { plant: @plant },
          formats: [:html]
        )

        render json: {
          error:   flash[:alert],
          content: partial
        }
      end
    end
  end

  def set_plant
    @plant = current_user.plants.find(params[:plant_id])
  end
end
