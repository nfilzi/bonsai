module Api
  module V1
    class PlantsController < ActionController::API
      def index
        plants = Plant.all

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
    end
  end
end
