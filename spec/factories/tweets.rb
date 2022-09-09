FactoryBot.define do
  factory :tweet do
    body { Faker::JapaneseMedia::StudioGhibli.quote }
    association :user
  end
end
