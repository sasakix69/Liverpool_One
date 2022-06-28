class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  # 同じツイートを複数回お気に入り登録させないため。
  validates :user_id, uniqueness: { scope: :tweet_id }
end
