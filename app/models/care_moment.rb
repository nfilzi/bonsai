class CareMoment < ApplicationRecord
  belongs_to :plant

  validates :code,   presence: true, inclusion: { in: MOMENTS.keys.map(&:to_s) }
  validates :points, presence: true, numericality: { greater_than: 0 }
end
