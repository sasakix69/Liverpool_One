FactoryBot.define do
  factory :comment do
    association :user
    association :tweet
    body { 'テストコメント' }
  end
end
