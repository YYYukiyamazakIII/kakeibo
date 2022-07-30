require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # Basic認証の情報を入力する
      sleep 10
      # トップページにサインアップページに遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      select @user.prefecture.name, from: "user[prefecture_id]"
      fill_in 'user_city', with: @user.city
      fill_in 'formGroupExampleInput', with: @user.profile
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができない時' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      select "--", from: "user[prefecture_id]"
      fill_in 'user_city', with: ''
      fill_in 'formGroupExampleInput', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができる時' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されていることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ログインができない時' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq user_session_path
    end
  end
end

RSpec.describe "ユーザー詳細", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context "ユーザー詳細ページに移動できる時" do
    it 'ログインすればユーザー詳細ページに移動できる' do
      # ログインする
      visit root_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name=commit]').click
      # ユーザー詳細ページへのリンクがあることを確認する
      expect(page).to have_link 'マイページ', href: user_path(@user)
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # ユーザー情報が存在することを確認する
      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
      expect(page).to have_content "#{@user.prefecture.name} #{@user.city}"
      expect(page).to have_content @user.profile
    end
  end

  context "ユーザー詳細ページに移動できない時" do
    it 'ログインをしていないとユーザー詳細ページに移動できない' do
      # トップページに移動する
      visit root_path
      # ユーザー詳細ページへのリンクが存在しないことを確認する
      expect(page).to have_no_link 'マイページ', href: user_path(@user)
    end
  end
end

RSpec.describe "ユーザー編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ユーザー編集ができる時' do
    it 'ログインをして正しい情報を入力すればユーザー編集ができる' do
      # ログインする
      visit root_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name=commit]').click
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # ユーザー編集ページへのリンクがあることを確認する
      expect(page).to have_link '編集する', href: edit_user_registration_path
      # ユーザー編集ページに移動する
      visit edit_user_registration_path
      # ユーザー情報を編集する
      fill_in "user_name", with: "#{@user.name}編集済み"
      fill_in "user_email", with: "#{@user.email}edited"
      select "北海道", from: "user[prefecture_id]"
      fill_in 'user_city', with: "#{@user.city}編集済み"
      fill_in 'formGroupExampleInput', with: "#{@user.profile}編集済み"
      fill_in 'user_current_password', with: @user.password
      # 編集をしてもUsrモデルのカウントは変わらないことを確認する
      expect{
        find('input[name=commit]').click
      }.to change { User.count }.by(0)
      # 編集後はトップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ユーザー詳細ページへ移動しユーザー情報が編集されていることを確認する
      visit user_path(@user)
      expect(page).to have_content "#{@user.name}編集済み"
      expect(page).to have_content "#{@user.email}edited"
      expect(page).to have_content "北海道 #{@user.city}編集済み"
      expect(page).to have_content "#{@user.profile}編集済み"
    end
  end

  context 'ユーザー編集ができない時' do
    it '誤った情報を入力すればユーザー編集ができない' do
      # ログインする
      visit root_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name=commit]').click
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # ユーザー編集ページへのリンクがあることを確認する
      expect(page).to have_link '編集する', href: edit_user_registration_path
      # ユーザー編集ページに移動する
      visit edit_user_registration_path
      # ユーザー情報を編集する
      fill_in "user_name", with: ""
      fill_in "user_email", with: ""
      select "--", from: "user[prefecture_id]"
      fill_in 'user_city', with: ""
      fill_in 'formGroupExampleInput', with: ""
      fill_in 'user_current_password', with: @user.password
      # 編集をしてもUsrモデルのカウントは変わらないことを確認する
      expect{
        find('input[name=commit]').click
      }.to change { User.count }.by(0)
      # ユーザー編集ページに戻されることを確認する
      expect(current_path).to eq user_registration_path
    end

    it 'ログインをしていないとユーザー編集できない' do
       # トップページに移動する
       visit root_path
       # ユーザー詳細ページへのリンクが存在しないことを確認する
       expect(page).to have_no_link 'マイページ', href: user_path(@user)
    end
  end
end