require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー式登録' do

    it 'name,email,password,password_confirmation,prefecture_id,city,profileが存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nameが空では登録できない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "名前を入力してください"
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールを入力してください"
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワードを入力してください"
    end
    it 'password_confirmationが空では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
    end
    it 'prefecture_idが空では登録できない' do
      @user.prefecture_id = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "都道府県を入力してください"
    end
    it 'cityが空では登録できない' do
      @user.city = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "市区町村を入力してください"
    end
    it 'profileが空では登録できない' do
      @user.profile = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "プロフィールを入力してください"
    end
  end
end
