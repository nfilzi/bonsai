class PlantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @query  = params[:query]
    pattern = @query.presence || '*'

    @search = Plant.search(
      pattern,
      order: { created_at: :desc },
      scope_results: ->(results) { results.includes(:user) }
    )

    @plants = @search.results
  end

  def show
    @plant = Plant.find(params[:id])
    @gardener_other_plants = @plant.user.plants.where.not(id: @plant.id)
  end
end
