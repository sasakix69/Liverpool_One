FactoryBot.define do
  factory :bookmark do
    association :tweet
    user { tweet.user }
  end
end
