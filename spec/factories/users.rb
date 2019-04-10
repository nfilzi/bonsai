FactoryBot.define do
  factory :users, class: User do
    nickname     { 'foobar' }
    password     { 'secret' }
    level        { 2 }
    care_points  { 300 }

    sequence(:email) { |n| "foo#{n}@mail.com" }
  end
end
