require 'delegate'

class PlantPresenter < SimpleDelegator
  attr_reader :plant

  def self.wrap(plants)
    plants.map { |plant| new(plant) }
  end

  def initialize(plant)
    @plant = plant
    super
  end

  def needed_care_moments
    @needed_care_moments ||= begin
      CareMoment::MOMENTS.keys.map do |code|
        code if plant["#{code}_needed"] == 1
      end.
      compact
    end
  end

  def care_moment_action_css_color(code)
    action_css_colors_table[code.to_sym] || "secondary"
  end

  def size_description_for_human
    human_sizes_table[plant.size] || "so tall"
  end

  private

  def action_css_colors_table
    {
      water: "info",
      repot: "success"
    }
  end

  def human_sizes_table
    {
      'small'  => "quite small",
      'medium' => "almost tall"
    }
  end
end
