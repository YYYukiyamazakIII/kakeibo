FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { Faker::Lorem.characters( number: 10, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    prefecture_id         { Faker::Number.between(from: 2, to: 48) }
    city                  { Faker::Address.city }
    profile               { Faker::Lorem.sentence }
  end
end