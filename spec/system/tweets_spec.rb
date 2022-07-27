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

  context 'つぶやき投稿ができない時' do
    it 'ログインしていないとつぶやき一覧ベージに移動できない' do
      # トップページに遷移する
      visit root_path
      # つぶやきページへのボタンがあることを確認する
      expect(page).to have_content "つぶやき"
      # つぶやき一覧ページへ移動してもトップページに戻されることを確認する
      visit tweets_path
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'つぶやき編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end

  context 'つぶやき編集ができる時' do
    it 'ログインしたユーザーは自分が投稿したつぶやきの編集ができる' do
      # @tweet1を投稿したユーザーでログインする
      visit root_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name=commit]').click
      # つぶやき一覧ページへ移動する
      visit tweets_path
      # @tweet1に編集へのリンクがあることを確認する
      expect(
        all('.dropdown')[0].click
      ).to have_link '編集する', href: edit_tweet_path(@tweet1)
      # 編集ページへ移動する
      visit edit_tweet_path(@tweet1)
      # 投稿内容を編集する
      fill_in 'exampleFormControlTextarea1', with: "#{@tweet1.text}+編集済み"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name=commit]').click
      }.to change { Tweet.count }.by(0)
      # 編集後はつぶやき一覧ページに移動することを確認する
      expect(current_path).to eq tweets_path
      # つぶやき一覧ページには先ほど変更した内容のつぶやきが存在することを確認する
      expect(page).to have_content "#{@tweet1.text}+編集済み"
    end
  end
end