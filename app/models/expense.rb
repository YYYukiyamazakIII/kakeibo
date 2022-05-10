class Expense < ApplicationRecord
  validates :value, presence: true
  validates :category_id, numericality: { other_than:1 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
end
