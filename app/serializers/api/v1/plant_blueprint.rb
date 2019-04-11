module Api
  module V1
    class PlantBlueprint < Blueprinter::Base
      identifier :id

      fields :name, :age_in_months, :size

      view :with_owner do
        association :owner, blueprint: UserBlueprint
      end
    end
  end
end
