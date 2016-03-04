FactoryGirl.define do
  factory :message do
    name
    email
    message Faker::Lorem.paragraph
    created_at Faker::Time.between(DateTime.now - 1, DateTime.now)
  end
end
