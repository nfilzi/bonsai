class Plant < ApplicationRecord
  belongs_to :user
  has_many :care_moments, dependent: :destroy

  validates :name, presence: true
end
