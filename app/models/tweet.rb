class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :good_tweets, dependent: :destroy

  validates :text, presence: true
end
