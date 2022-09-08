FactoryBot.define do
  factory :user do
    username              { 'test' }
    email                 { 'TEST@example.com' }
    password              { 'testuser' }
    password_confirmation { 'testuser' }
    after(:create) { |user| user.confirm }
  end
end
