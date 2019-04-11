module Api
  module V1
    class UserBlueprint < Blueprinter::Base
      identifier :id

      fields :nickname, :level, :care_points
    end
  end
end
