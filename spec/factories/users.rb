FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password Faker::Internet.password
    confirmed_at DateTime.now
    role 'standard'
  end
end
