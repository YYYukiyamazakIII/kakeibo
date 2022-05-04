class Expense < ApplicationRecord
  validates :value, presense: true
end
