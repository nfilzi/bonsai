FactoryBot.define do
  factory :care_moments, class: CareMoment do
    code   { CareMoment::MOMENTS.keys.sample }
    points { CareMoment::MOMENTS[code][:points] }

    date   { ((Date.today - 20)..Date.today).to_a.sample }

    trait :with_plant do
      association :plant, factory: :plants
    end
  end

end
