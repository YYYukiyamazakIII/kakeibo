require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe "コメント新規登録" do

    it 'コメントが存在しuser、tweetが紐づいていると登録できる' do
      expect(@comment).to be_valid
    end

    it 'textが空だと登録できない' do
      @comment.text = ''
      @comment.valid?
      expect(@comment.errors.full_messages).to include "テキストを入力してください"
    end

    it 'textが101文字以上だと登録できない' do
      @comment.text = Faker::Lorem.characters( number: 101 )
      @comment.valid?
      expect(@comment.errors.full_messages).to include "テキストは100文字以内で入力してください"
    end

    it 'userが紐づいていないと登録できない' do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include "Userを入力してください"
    end

    it 'tweetが紐づいていないと登録できない' do
      @comment.tweet = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include "Tweetを入力してください"
    end
  end
end
