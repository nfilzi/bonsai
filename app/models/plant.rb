class Plant < ApplicationRecord
  searchkick
  scope :search_import, -> { includes(:owner) }

  ROOMS = %w(entrance living-room bedroom bathroom office)
  SIZES = %w(small medium tall)

  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  has_many :care_moments, dependent: :destroy

  validates :name, presence: true

  scope :include_care_status, -> do
    selects = []
    joins   = []

    CareMoment::MOMENTS.each do |code, specs|
      expected_date = Date.tomorrow - specs[:min_frequency_in_days].days

      selects << <<~EOF
        CASE
          WHEN
            moment_#{code}.code IS NULL
            OR
            moment_#{code}.date < '#{expected_date}'
          THEN 1
          ELSE 0
        END AS #{code}_needed
      EOF

      joins << <<~EOF
        LEFT OUTER JOIN care_moments moment_#{code} on moment_#{code}.id = (
          SELECT id
          FROM  care_moments
          WHERE care_moments.code = '#{code}' AND care_moments.plant_id = plants.id
          ORDER BY date desc
          LIMIT 1
        )
      EOF
    end

    select("plants.*, #{selects.join(', ')}").joins(joins.join)
  end

  scope :needing_care, -> do
    conditions = CareMoment::MOMENTS.map do |code, specs|
      expected_date = Date.tomorrow - specs[:min_frequency_in_days].days

      <<~EOF
        (
          moment_#{code}.id IS NULL
          OR
          (
            moment_#{code}.code = '#{code}'
            AND
            moment_#{code}.date < '#{expected_date}'
          )
        )
      EOF
    end

    include_care_status.where(conditions.join(' OR '))
  end

  private

  def search_data
    {
      id:            id,
      name:          name,
      age_in_months: age_in_months,
      size:          size,
      room:          room,
      photo_url:     photo_url,
      created_at:    created_at,
      owner: {
        id:       owner.id,
        nickname: owner.nickname,
        email:    owner.email
      }
    }
  end
end
