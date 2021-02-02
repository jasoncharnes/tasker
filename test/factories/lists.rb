FactoryBot.define do
  factory :list do
    team
    name { Faker::Hipster.sentence }
  end
end
