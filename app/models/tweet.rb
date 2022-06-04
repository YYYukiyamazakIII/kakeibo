class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments

  validates :text, :user_id, presence: true
end
