class GoodTweet < ApplicationRecord
  validates :tweet_id, uniqueness: { scope: :user_id }
  belongs_to :tweet
  belongs_to :user
end
