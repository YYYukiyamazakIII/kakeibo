class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  has_many :tweets
  has_many :comments
  has_many :good_tweets

  validates :name, presence: true, length: { maximum: 20 }
  validates :prefecture_id, presence: true, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 48 }
  validates :city, presence: true, length: { maximum: 40 }
  validates :profile, presence: true, length: { maximum: 200 }
end
