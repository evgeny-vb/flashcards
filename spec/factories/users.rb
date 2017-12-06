FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@test.te" }
    password '123456'
    password_confirmation '123456'
  end
end
