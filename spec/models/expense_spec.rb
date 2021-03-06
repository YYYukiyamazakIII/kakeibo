require 'rails_helper'

RSpec.describe Expense, type: :model do
  before do
    @expense = FactoryBot.build(:expense)
  end

  describe '出費新規登録' do
    it 'name, value, category_id, dateが正しく入力され、userが紐づているとき登録できる' do
      expect(@expense).to be_valid
    end
    it 'nameが空では登録できない' do
      @expense.name = ""
      @expense.valid?
      expect(@expense.errors.full_messages).to include "名前を入力してください"
    end

    it 'nameが31文字以上では登録できない' do
      @expense.name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      @expense.valid?
      expect(@expense.errors.full_messages).to include "名前は30文字以内で入力してください"
    end

    it 'valueが空では登録できない' do
      @expense.value = ""
      @expense.valid?
      expect(@expense.errors.full_messages).to include "値段を入力してください"
    end

    it 'valueが0以下では登録できない' do
      @expense.value = 0
      @expense.valid?
      expect(@expense.errors.full_messages).to include "値段は1以上の値にしてください"
    end

    it 'valueが10000000以上では登録できない' do
      @expense.value = 10000000
      @expense.valid?
      expect(@expense.errors.full_messages).to include "値段は9999999以下の値にしてください"
    end

    it 'category_idが空では登録できない' do
      @expense.category_id = ""
      @expense.valid?
      expect(@expense.errors.full_messages).to include "カテゴリを入力してください"
    end

    it 'category_idが1以外では登録できない' do
      @expense.category_id = 1
      @expense.valid?
      expect(@expense.errors.full_messages).to include "カテゴリは2以上の値にしてください"
    end

    it 'category_idが18以上では登録できない' do
      @expense.category_id = 18
      @expense.valid?
      expect(@expense.errors.full_messages).to include "カテゴリは17以下の値にしてください"
    end

    it 'dateが空では登録できない' do
      @expense.date = ""
      @expense.valid?
      expect(@expense.errors.full_messages).to include "日付を入力してください"
    end

    it 'userが紐づいていないと登録できない' do
      @expense.user = nil
      @expense.valid?
      expect(@expense.errors.full_messages).to include"Userを入力してください"
    end
  end
end
