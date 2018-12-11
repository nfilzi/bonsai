class PagesController < ApplicationController
  def home
    @latest_plants = Plant.order("created_at DESC").limit(3)
  end
end
