require 'rails_helper'

RSpec.describe "つぶやき投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end

  context 'つぶやき投稿ができる時' do
    it 'ログインしたユーザーは新規登録できる' do
      # ログインする
      visit root_path
      sleep 10
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name=commit]').click
      # つぶやきページへのボタンがあることを確認する
      expect(page).to have_content "つぶやき"
      # つぶやき一覧ページに移動する
      visit tweets_path
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content "投稿する"
      # 新規投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'exampleFormControlTextarea1', with: @tweet.text
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name=commit]').click
      }.to change { Tweet.count }.by(1)
      # つぶやき一覧ページに遷移することを確認する
      expect(current_path).to eq tweets_path
      # つぶやき一覧ページには先ほど投稿した内容のツイートが存在することを確認する
      expect(page).to have_content @tweet.text
    end
  end
end
