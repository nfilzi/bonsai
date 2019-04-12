module API
  class BaseBlueprint < Blueprinter::Base
    field :kind do |element, _|
      if element.is_a?(Searchkick::HashWrapper)
        element._type.camelize
      else
        element.class.to_s
      end
    end
  end
end
