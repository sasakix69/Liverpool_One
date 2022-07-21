class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 140 }
end
