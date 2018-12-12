class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @latest_plants = Plant.order("created_at DESC").limit(3)
  end
end
