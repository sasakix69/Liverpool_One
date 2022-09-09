FactoryBot.define do
  factory :user do
    username              { 'test' }
    email                 { Faker::Internet.email }
    password              { 'testuser' }
    password_confirmation { 'testuser' }
    after(:create) { |user| user.confirm }
  end
end
