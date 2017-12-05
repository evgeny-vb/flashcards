FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@test.te" }
    password "12345678"
  end
end
