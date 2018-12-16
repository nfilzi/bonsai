FactoryBot.define do
  factory :user do
    nickname { 'John' }
    password { '123456' }

    sequence(:email) { |n| "user-#{n}@example.com" }
  end
end
