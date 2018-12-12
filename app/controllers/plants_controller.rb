class PlantsController < ApplicationController
  def index
    @plants = Plant.order("created_at DESC")
  end
end
