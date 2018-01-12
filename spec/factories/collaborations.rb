FactoryBot.define do
  factory :collaboration do
    association :user
    association :wiki
  end
end
