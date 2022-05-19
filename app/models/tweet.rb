class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :text, :user_id, presence: true
end
