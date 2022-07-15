require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録' do

    it 'name,email,password,password_confirmation,prefecture_id,city,profileが存在すれば登録できる' do
      expect(@user).to be_valid
    end

    it 'nameが空では登録できない' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "名前を入力してください"
    end

    it 'nameが20文字以上では登録できない' do
      @user.name = Faker::Lorem.characters( number: 21 )
      @user.valid?
      expect(@user.errors.full_messages).to include "名前は20文字以内で入力してください"
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールを入力してください"
    end

    it 'emailは@が含まれていないと登録できない' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールは不正な値です"
    end

    it 'emailはすでに使用されているものは登録できない' do
      @another_user = FactoryBot.create(:user)
      @user.email = @another_user.email
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールはすでに存在します"
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワードを入力してください"
    end

    it 'passwordは5文字以下では登録できない' do
      @user.password = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
    end

    it 'passwordは129文字以上では登録できない' do
      @user.password = Faker::Lorem.characters( number: 129 )
      @user.valid?
      expect(@user.errors.full_messages).to include"パスワードは128文字以内で入力してください"
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

    it 'pregecture_idが1では登録できない' do
      @user.prefecture_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include "都道府県は2以上の値にしてください"
    end

    it 'prefecture_idは49以上では登録できない' do
      @user.prefecture_id = 49
      @user.valid?
      expect(@user.errors.full_messages).to include "都道府県は48以下の値にしてください"
    end

    it 'cityが空では登録できない' do
      @user.city = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "市区町村を入力してください"
    end

    it 'cityが41文字以上では登録できない' do
      @user.city = Faker::Lorem.characters( number: 41 )
      @user.valid?
      expect(@user.errors.full_messages).to include "市区町村は40文字以内で入力してください"
    end

    it 'profileが空では登録できない' do
      @user.profile = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "プロフィールを入力してください"
    end
    
    it 'profileが201文字以上では登録できない' do
      @user.profile = Faker::Lorem.characters( number: 201 )
      @user.valid?
      expect(@user.errors.full_messages).to include "プロフィールは200文字以内で入力してください"
    end

  end
end
