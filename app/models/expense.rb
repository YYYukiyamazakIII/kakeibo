class Expense < ApplicationRecord
  validates :date, :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 9999999 }
  validates :category_id, presence: true, numericality: { other_than: 1, message: 'を入力してください' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
end
