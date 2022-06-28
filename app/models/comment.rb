class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  validates :body, presence: true, length: { maximum: 140 }
end
