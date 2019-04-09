class Garden::CareMomentsController < ApplicationController
  before_action :ensure_code_presence

  def index
    @care_moments = current_user.care_moments.eager_load(:plant).order('date DESC')
  end

  def create
    plant  = Plant.find(params[:plant_id])
    result = Plants::CreateCareMoment.new(plant, params[:code]).call

    if result.success?
      flash[:notice] = "Action successfully saved."
    else
      flash[:alert] = result.errors_messages
    end

    redirect_to redirect_path
  end

  private

  def ensure_code_presence
    return if params[:code]

    flast[:alert] = "What action do you want to perform?"
    redirect_to redirect_path
  end

  def redirect_path
    params[:src] == 'dashboard' ? garden_root_path : garden_plant_path(plant)
  end
end
