class Expense < ApplicationRecord
  validates :name, :value, :category_id, :user_id, presence: true
  validates :category_id, numericality: { other_than: 1, message: 'cant be blank' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
end
