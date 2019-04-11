module API
  class BaseBlueprint < Blueprinter::Base
    field :kind do |element, _|
      element.class.to_s
    end
  end
end
