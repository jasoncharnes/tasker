FactoryBot.define do
  factory :user do
    team
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    password { "password" }
    password_confirmation { "password" }
  end
end
