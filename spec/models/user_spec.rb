require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー式登録' do

    it 'name,email,password,password_confirmation,prefecture_id,city,profileが存在すれば登録できる' do
      expect(@user).to be_valid
    end
    
  end
end
