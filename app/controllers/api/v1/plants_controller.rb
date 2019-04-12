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
        search = Plant.search(
          query,
          operator:      "or",
          where:         filters,
          aggs:          allowed_search_params,
          match:         :word_middle,
          scope_results: ->(results) { results.includes(:owner) },
          load:          false
        )

        plants = search.results

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

      def query
        query = params[:query]
        query ||= "*"
      end

      def allowed_search_params
        [:size, :room]
      end

      def filters
        params.slice(*allowed_search_params)
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
