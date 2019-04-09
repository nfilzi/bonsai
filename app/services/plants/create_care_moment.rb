module Plants
  class CreateCareMoment
    def initialize(plant, care_moment_code)
      @plant            = plant
      @care_moment_code = care_moment_code
      @errors           = []
    end

    def call
      if validate_contract
        build_care_moment

        if @care_moment.save
          update_plant_points
          update_plant_owner_points
          update_plant_owner_level
        else
          @errors << { code: :unable_to_save_action, message: "Unable to save the action." }
        end
      end

      return Result.new(@errors.empty?, @errors)
    end

    private

    def validate_contract
      @contract = Contract.new(@plant, @care_moment_code).validate
      @errors += @contract.errors

      @contract.valid?
    end

    def care_moment_specs
      @care_moment_specs ||= CareMoment::MOMENTS[@care_moment_code.to_sym]
    end

    def build_care_moment
      @care_moment = CareMoment.new(
        plant:  @plant,
        date:   Date.today,
        code:   @care_moment_code,
        points: care_moment_specs[:points]
      )
    end

    def update_plant_points
      UpdatePoints.new(@plant).call
    end

    def update_plant_owner_points
      ::Users::UpdateCarePoints.new(@plant.owner).call
    end

    def update_plant_owner_level
      ::Users::UpdateLevel.new(@plant.owner).call
    end
  end
end
