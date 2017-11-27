FactoryBot.define do
  factory :wiki do
    title 'MyString'
    body 'MyText'
    private false
    association :user
  end
end
