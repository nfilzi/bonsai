FactoryBot.define do
  factory :plants, class: Plant do
    name           { 'Roger' }
    age_in_months  { 3 }
    size           { 'small' }
    photo_url      { 'https://img-3.journaldesfemmes.fr/reCRzYkzv7psZov1ygWXI40WtQE=/910x607/smart/1c0c9fde8379424f9a32318875da1203/ccmcms-jdf/10950238.jpg' }
    care_moments   { [] }

    trait :with_owner do
      association :owner, factory: :users
    end

    trait :reindex do
      after(:create) do |plant, _evaluator|
        plant.reindex(refresh: true)
      end
    end
  end
end
