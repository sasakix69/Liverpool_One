class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :body, presence: true, length: { maximum: 140 }
  mount_uploader :tweet_image, TweetImageUploader
end
