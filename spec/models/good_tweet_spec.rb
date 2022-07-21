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
  end
end
