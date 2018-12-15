class CreateCareMomentService
  def initialize(plant, code)
    @plant = plant
    @code  = code
    @user  = plant.user
  end

  def call
    @moment = setup_care_moment

    if @moment.save
      update_plant_care_points
      update_user_care_points_and_level
      return true
    else
      return false
    end
  end

  private

  def setup_care_moment
    return CareMoment.new(
      plant:  @plant,
      date:   Date.today,
      code:   @code,
      points: CareMoment::MOMENTS[@code.to_sym][:points]
    )
  end

  def update_plant_care_points
    # NOTE: We delegate to another service (SRP)
    UpdatePlantCarePointsService.new(@plant).call
  end

  def update_user_care_points_and_level
    # NOTE: We delegate to another service (SRP)
    UpdateUserPointsAndLevelService.new(@user).call
  end
end
