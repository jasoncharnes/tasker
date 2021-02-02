FactoryBot.define do
  factory :task do
    list
    name { Faker::Hipster.sentence }
  end
end
