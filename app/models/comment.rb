class Comment < ApplicationRecord
  validates :text, :user_id, :tweet_id, presence: true

  belongs_to :user
  belongs_to :tweet
end
