class Expense < ApplicationRecord
  validates :date, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 9999999 }
  validates :category_id, presence: true, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 17 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :user
end
