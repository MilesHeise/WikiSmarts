require 'faker'

# Create Users
5.times do
  User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password
  )
end
users = User.all

# Creat Wikis
15.times do
  Wiki.create!(
    title:  Faker::Book.title,
    body:   Faker::Lorem.paragraphs,
    private: false,
    user: users.sample
  )
end
wikis = Wiki.all

# Create an admin user
admin = User.create!(
  email:    'admin@example.com',
  password: 'helloworld',
  # role:     'admin'  #need to uncomment and reseed after I merge Pundit branch
)

# Create a standard member
member = User.create!(
  email:    'member@example.com',
  password: 'helloworld'
)

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
