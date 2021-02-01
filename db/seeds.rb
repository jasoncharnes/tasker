team = Team.create(name: "SR Team")

user = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "user@example.com",
  password: "password",
  password_confirmation: "password",
  team: team
)

users = 5.times.map do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    password: "password",
    password_confirmation: "password",
    team: team
  )
end

list = List.create(name: Faker::Hipster.sentence, team: team)

tasks = 5.times.map do
  completed = Faker::Boolean.boolean(true_ratio: 0.2)
  list.tasks.create(
    creator: users.sample,
    name: Faker::Hipster.sentence,
    completed_at: completed ? Time.current : nil,
    completer: completed ? users.sample : nil
  )
end

10.times do
  Comment.create(user: users.sample, commentable: tasks.sample, body: Faker::Hipster.paragraph)
end
