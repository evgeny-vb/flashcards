FactoryBot.define do
  factory :card do
    sequence(:original_text) { |n| "Original text #{n}" }
    sequence(:translated_text) { |n| "Translated text #{n}" }
    review_date Date.today

    association :user, factory: :user
  end
end
