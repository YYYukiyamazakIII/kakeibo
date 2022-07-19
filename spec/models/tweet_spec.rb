require 'rails_helper'

RSpec.describe Tweet, type: :model do

  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'つぶやき新規登録' do

    it 'textが存在しuserが紐づいていれば登録できる' do
      expect(@tweet).to be_valid
    end

    it 'textが空だと登録できない' do
      @tweet.text = ''
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include "テキストを入力してください"
    end

    it 'userが紐づいていないと登録できない' do
      @tweet.user = nil
      @tweet.valid?
      expect( @tweet.errors.full_messages).to include "Userを入力してください" 
    end

  end

end
