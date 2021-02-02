FactoryBot.define do
  factory :team do
    name { Faker::Company.name }
  end
end
