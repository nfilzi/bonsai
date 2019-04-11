module API
  module V1
    class UserBlueprint < BaseBlueprint
      identifier :id

      fields :nickname, :level, :care_points
    end
  end
end
