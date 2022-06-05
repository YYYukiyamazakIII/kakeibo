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

  validates :name, :prefecture_id, :city, :profile, presence: true
  validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }
end
