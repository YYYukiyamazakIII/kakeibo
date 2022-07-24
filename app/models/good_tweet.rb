class GoodTweet < ApplicationRecord
  validates :tweet_id, uniqueness: true
  belongs_to :tweet
  belongs_to :user
end
