class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '食費' },
    { id: 3, name: '日用品' },
    { id: 4, name: '趣味・娯楽' },
    { id: 5, name: '交際費' },
    { id: 6, name: '交通費' },
    { id: 7, name: '衣服・美容' },
    { id: 8, name: '健康・医療' },
    { id: 9, name: '自動車' },
    { id: 10, name: '教養・教育' },
    { id: 11, name: '特別な出費' },
    { id: 12, name: '水道・光熱費' },
    { id: 13, name: '通信費' },
    { id: 14, name: '住宅' },
    { id: 15, name: '税・社会保障' },
    { id: 16, name: '保険' },
    { id: 17, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :expenses
end