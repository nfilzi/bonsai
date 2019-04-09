module Plants
  class UpdatePoints
    def initialize(plant)
      @plant = plant
    end

    def call
      @plant.update(care_points: @plant.care_moments.sum(:points))
    end
  end
end
