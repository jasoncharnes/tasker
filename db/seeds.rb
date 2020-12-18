user = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "user@example.com",
  password: "password",
  password_confirmation: "password"
)

users = 5.times.map do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password"
  )
end

list = List.create(name: Faker::Hipster.sentence)

10.times do
  list.tasks.create(
    creator: users.sample,
    name: Faker::Hipster.sentence,
    completed_at: Faker::Boolean.boolean(true_ratio: 0.2) ? Time.current : nil
  )
end
