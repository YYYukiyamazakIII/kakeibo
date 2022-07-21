FactoryBot.define do
  factory :good_tweet do
    association :user
    association :tweet
  end
end