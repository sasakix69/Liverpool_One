class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :body, presence: true, length: { maximum: 140 }
  mount_uploader :tweet_image, TweetImageUploader
end
