require 'faker'

# Create Users
5.times do
  User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password,
    confirmed_at: DateTime.now
  )
end
users = User.all

# Create Wikis
15.times do
  Wiki.create!(
    title:  Faker::Book.title,
    body:   Faker::Lovecraft.paragraphs(rand(2..8)).join("\n\n"),
    private: false,
    user: users.sample
  )
end
wikis = Wiki.all

# Create an admin user
admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  confirmed_at: DateTime.now,
  role: 'admin'
)

# Create a premium user
premium = User.create!(
  email:    'premium@example.com',
  password: 'helloworld',
  confirmed_at: DateTime.now,
  role: 'premium'
)

# Create a standard member
member = User.create!(
  email:    'member@example.com',
  password: 'helloworld',
  confirmed_at: DateTime.now
)

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
