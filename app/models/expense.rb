class Expense < ApplicationRecord
  validates :date, :name, :value, :category_id, :user_id, presence: true
  validates :category_id, numericality: { other_than: 1, message: 'を入力してください' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
end
