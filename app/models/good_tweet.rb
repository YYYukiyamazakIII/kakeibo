class GoodTweet < ApplicationRecord
  validates :tweet_id, :user_id, presence: true

  belongs_to :tweet
  balongs_to :user
end
