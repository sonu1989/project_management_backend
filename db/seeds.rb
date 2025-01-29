
User.create!(name: 'Admin User', email: 'admin@example.com', role: :admin, password: 'password')

5.times { User.create!(name: Faker::Name.name, email: Faker::Internet.email, role: :user, password: 'password') }

3.times do
  Project.create!(
    name: Faker::App.name,
    start_date: Date.today - rand(1..10).days,
    duration: "#{rand(1..12)} weeks"
  )
end
