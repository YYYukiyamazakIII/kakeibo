FactoryBot.define do
  factory :expense do
    name        { Faker::Lorem.word }
    value       { Faker::Number.between(from: 1, to: 9999999) }
    category_id { Faker::Number.between(from: 2, to: 17) }
    date        { Date.today }
    user_id     { 1 }
  end
end