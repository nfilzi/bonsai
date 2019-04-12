module API
  module V1
    class PlantsController < BaseController
      skip_before_action :authorize_request, only: [:index, :show]

      def create
        plant       = Plant.new(plant_params)
        plant.owner = current_user

        if plant.save
          render json: PlantBlueprint.render(plant, view: :with_owner, root: :plants)
        else
          head :unprocessable_entity
        end
      end

      def index
        plants = if conditions.empty?
          Plant.search('*', load: false).results
        else
          Plant.search('*', where: conditions, load: false).results
        end

        render json: PlantBlueprint.render(plants, root: :plants)
      end

      def show
        plant = Plant.find(params[:id])

        json = if params[:with_owner]
          PlantBlueprint.render(plant, view: :with_owner, root: :plants)
        else
          PlantBlueprint.render(plant, root: :plants)
        end

        render json: json
      end

      private

      def conditions
        @conditions ||= params.slice(:size, :room)
      end

      def plant_params
        params.require(:plant).permit(
          :name,
          :age_in_months,
          :size,
          :room,
          :photo_url
        )
      end
    end
  end
end
