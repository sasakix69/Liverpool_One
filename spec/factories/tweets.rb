FactoryBot.define do
  factory :tweet do
    body { Faker::JapaneseMedia::StudioGhibli.quote }
  end
end
