FactoryGirl.define do
  sequence(:email) { |n| "#{Faker::Internet.free_email}" }
  sequence(:name) { |n| "#{Faker::Name.name}" }
  sequence(:nickname) { |n| "#{Faker::Internet.user_name}" }
  password = Faker::Internet.password(8)
  factory :user do |u|
    u.email
    u.name
    u.nickname
    u.password password
    u.password_confirmation password
  end
end
