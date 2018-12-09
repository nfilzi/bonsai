class Plant < ApplicationRecord
  belongs_to :user
  has_many :care_moments, dependent: :destroy
end
