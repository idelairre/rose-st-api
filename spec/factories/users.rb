FactoryGirl.define do
  sequence(:email) { |n| "#{Faker::Internet.email}" }
  password = Faker::Internet.password(8)
  factory :user do |u|
    u.email
    u.password password
    u.password_confirmation password
    u.confirmed_at Date.today
  end
end
