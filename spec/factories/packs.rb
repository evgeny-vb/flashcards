FactoryBot.define do
  factory :pack do
    sequence(:name) { |n| "Pack name #{n}" }

    association :user
  end
end
