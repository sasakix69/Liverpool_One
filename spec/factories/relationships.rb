FactoryBot.define do
  factory :relationship do
    association :user
    follow_id    { FactoryBot.create(:user).id }
    user_id      { FactoryBot.create(:user).id }
  end
end
