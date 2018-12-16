class User < ApplicationRecord
  LEVELS = {
    # NUMBER : RANGE
    # beginner
    0 => 0...10,
    # now
    1 => 10...20,
    # one week
    2 => 20...100,
    # one month
    3 => 100...500,
    # not so quick (4-5 month)
    4 => 500...1300,
    # one year
    5 => 1300...1985,
    # one year and a half
    6 => 1985..Float::INFINITY
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :plants, dependent: :destroy
  has_many :care_moments, through: :plants
end
