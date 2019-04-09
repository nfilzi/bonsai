class Garden::PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :edit, :update, :destroy]

  def index
    @plants = current_user.plants
  end

  def show
    @moments = @plant.care_moments.order("date DESC")

    @last_moment_per_code = @plant.care_moments.
      select('max(date) AS date, code').
      group(:code).
      # [
      #   <CareMoment code="water">,
      #   <CareMoment code="repot">,
      #   <CareMoment code="weed">
      # ]
      each_with_object({}) { |moment, moments| moments[moment.code] = moment }
      # => {
      #   water: <CareMoment code="water">,
      #   repot: <CareMoment code="repot">,
      #   weed:  <CareMoment code="weed">
      # }
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.owner = current_user

    if @plant.save
      flash[:notice] = 'Your plant was successfully added to your garden.'
      redirect_to garden_plant_path(@plant)
    else
      flash.now[:alert] = 'Unable to add your plant'
      render :new
    end
  end

  def edit
  end

  def update
    @plant.assign_attributes(plant_params)

    if @plant.save
      flash[:notice] = 'Your plant was successfully updated.'
      redirect_to garden_plant_path(@plant)
    else
      flash.now[:alert] = 'Unable to update your plant'
      render :edit
    end
  end

  def destroy
    @plant.destroy!
    redirect_to garden_plants_path
  end

  private

  def plant_params
    params.require(:plant).permit(
      :name,
      :age_in_months,
      :size,
      :room,
      :photo_url
    )
  end

  def set_plant
    @plant = current_user.plants.include_care_status.find(params[:id])
    @plant = PlantPresenter.new(@plant)
  end
end
