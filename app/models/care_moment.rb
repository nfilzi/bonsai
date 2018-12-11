class CareMoment < ApplicationRecord
  MOMENTS = {
    weed: {
      points: 2, # per month : 4
      min_frequency_in_days: 15
    },
    water: {
      points: 10, # per month : 80
      min_frequency_in_days: 3
    },
    repot: {
      points: 100, # per month : 25
      min_frequency_in_days: 300
    }
  }

  belongs_to :plant

  validates :code,   presence: true, inclusion: { in: MOMENTS.keys.map(&:to_s) }
  validates :points, presence: true
end
