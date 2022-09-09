FactoryBot.define do
  factory :user do
    username              { 'test' }
    email                 { Faker::Internet.email }
    password              { 'testuser' }
    password_confirmation { 'testuser' }
    avatar                { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    after(:create) { |user| user.confirm }
  end
end
