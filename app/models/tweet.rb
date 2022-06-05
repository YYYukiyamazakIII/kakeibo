class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :good_tweets

  validates :text, :user_id, presence: true
end
