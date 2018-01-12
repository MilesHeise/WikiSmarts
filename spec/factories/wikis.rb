FactoryBot.define do
  factory :wiki do
    title Faker::Book.title
    body Faker::Lovecraft.paragraph
    private false
    association :user
  end
end
