FactoryBot.define do
  factory :task do
    list
    name { Faker::Hipster.sentence }
    association :creator, factory: :user

    trait :complete do
      completed_at { 1.week.ago }
      association :completer, factory: :user
    end
  end
end
