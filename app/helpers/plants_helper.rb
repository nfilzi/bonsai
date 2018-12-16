module PlantsHelper
  def human_plant_size(plant)
    case plant.size
    when 'small'  then 'quite small'
    when 'medium' then 'almost tall'
    else 'so tall'
    end
  end

  def plant_care_moments_needed(plant)
    moments = []

    CareMoment::MOMENTS.keys.each do |code|
      next unless plant["#{code}_needed"] == 1
      moments << code
    end

    return moments
  end
end
