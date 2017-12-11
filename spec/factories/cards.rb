FactoryBot.define do
  factory :card do
    sequence(:original_text) { |n| "Original text #{n}" }
    sequence(:translated_text) { |n| "Translated text #{n}" }
    review_date Date.today
    success_count 0
    fail_count 0

    association :pack
  end
end
