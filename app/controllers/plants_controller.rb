class PlantsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @query  = params[:query]
    pattern = @query.presence || '*'

    aggs     = [:age_in_months, :size, :room, :user_level]
    @filters = params.permit(*aggs)

    @search = Plant.search(
      pattern,
      order: { created_at: :desc },
      aggs:  aggs,
      where: @filters,
      scope_results: ->(results) { results.includes(:user) }
    )

    @plants = @search.results
  end

  def show
    @plant = Plant.find(params[:id])
    @gardener_other_plants = @plant.user.plants.where.not(id: @plant.id)
  end
end
