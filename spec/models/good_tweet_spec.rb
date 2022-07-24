require 'rails_helper'

RSpec.describe GoodTweet, type: :model do
  before do
    @good_tweet = FactoryBot.build(:good_tweet)
  end

  describe 'いいね登録' do
    it 'user,tweetが紐づいていれば登録できる' do
      expect(@good_tweet).to be_valid
    end

    it 'userが紐づいていないと登録できない' do
      @good_tweet.user = nil
      @good_tweet.valid?
      expect(@good_tweet.errors.full_messages).to include "Userを入力してください"
    end

    it 'tweetが紐づいていないと登録できない' do
      @good_tweet.tweet = nil
      @good_tweet.valid?
      expect(@good_tweet.errors.full_messages).to include "Tweetを入力してください"
    end

    it 'いいね登録したツイートを重複していいね登録できない' do
      another_good_tweet = FactoryBot.create(:good_tweet)
      @good_tweet.user_id = another_good_tweet.user_id
      @good_tweet.tweet_id = another_good_tweet.tweet_id
      @good_tweet.valid?
      expect(@good_tweet.errors.full_messages).to include "Tweetはすでに存在します"
    end
  end
end
