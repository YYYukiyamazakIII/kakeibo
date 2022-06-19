# アプリケーション名
kakeibo</br>
</br>
# アプリケーション概要
家計管理を行い、情報をシェアすることで倹約しやすくなる。</br>
</br>
# URL
https://kakeibo-37384.herokuapp.com/</br>
</br>
# テスト用アカウント
・Basic認証ID：admin</br>
・Basic認証パスワード：2222</br>
・メールアドレス：test@test.com</br>
・パスワード：test01</br>
</br>
# 利用方法
## 家計簿投稿
１.ヘッダーから「家計簿」ボタンをクリックする</br>
２.カレンダー内にある投稿したい日付の「0円」ボタンをクリックする</br>
３.名前、値段、カテゴリを入力し「登録」ボタンをクリックする
## つぶやき投稿
１.ヘッダーから「つぶやき」ボタンをクリックする</br>
２.「投稿する」ボタンをクリックする</br>
３.テキスト、画像（任意）を入力し「投稿する」ボタンをクリックする</br>
</br>
# アプリケーションを作成した背景
学生時代の友人に課題をヒアリングし、「実家を出て一人暮らしを始めたため節約したいが、仕事が忙しく家計管理がうまくできない」という課題を抱えていることが判明した。課題を分析した結果、「家計簿を記載する時間がない」、「近隣の住民と交流が少なく安いスーパーや薬局がわからない」ということが真因であると仮説を立てた。同様の問題を抱えている方も多いと推測し、真因を解決するために、ユーザー同士のコミュニケーションにより各地域情報を得ることができるSNS機能を備えた家計管理アプリケーションを開発することにした。</br>
</br>
# 洗い出した要件
https://docs.google.com/spreadsheets/d/1DzgCfMTmyKsmHbIa0WwnY1Lx5rZ4sSE5ByzHF8AKtm4/edit#gid=982722306</br>
</br>
# 実装した機能についての画像やGIFおよびその説明
出費の登録は非同期通信です。登録後は名前、カテゴリ、値段が表示され、合計金額が加算されます。
[![Image from Gyazo](https://i.gyazo.com/8df9e32ac505ef6910186e9e4a2c80de.gif)](https://gyazo.com/8df9e32ac505ef6910186e9e4a2c80de)</br>
</br>
登録後は一度更新すると「編集」ボタン及び「削除」ボタンが表示されます。いずれも非同期通信で行えます。
[![Image from Gyazo](https://i.gyazo.com/a28a71fbaaf50e7f1323cb7a14f73109.gif)](https://gyazo.com/a28a71fbaaf50e7f1323cb7a14f73109)</br>
</br>
出費一覧ページではカレンダー内に各日ごとの合計金額が表示されます。また、右側にその月の合計金額がカテゴリ別に表示されます。
[![Image from Gyazo](https://i.gyazo.com/221c65d8a1d80e0af2e46993d41964c5.jpg)](https://gyazo.com/221c65d8a1d80e0af2e46993d41964c5)</br>
</br>
投稿されたつぶやきは「いいね」ボタンと「コメント」ボタンが表示されます。いいねしていないつぶやきの「いいね」ボタンをクリックするとカウントが1増えます。また、いいねしているつぶやきの「いいね」ボタンをクリックするとカウントが1減ります。
[![Image from Gyazo](https://i.gyazo.com/05573db32b4294b033785e7b158238c5.gif)](https://gyazo.com/05573db32b4294b033785e7b158238c5)</br>
</br>
コメントを投稿するとつぶやき一覧ページの「コメント」ボタンの件数が1増えます。
[![Image from Gyazo](https://i.gyazo.com/e3ebd8730c5a8a516b37310082288fb8.gif)](https://gyazo.com/e3ebd8730c5a8a516b37310082288fb8)</br>
</br>
# データベース設計
[![Image from Gyazo](https://i.gyazo.com/8071dfd342d259d320e59325b86d6d27.png)](https://gyazo.com/8071dfd342d259d320e59325b86d6d27)</br>
</br>
# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/0d991bf9afa85f8425e4c63ad6b05a84.png)](https://gyazo.com/0d991bf9afa85f8425e4c63ad6b05a84)</br>
</br>
# 開発環境
・Ruby</br>
・Ruby on Rails</br>
・JavaScript</br>
・MySQL</br>
・GitHub</br>
・Heroku</br>
・Visual Studio Code</br>
</br>
# ローカルでの動作方法
% git clone https://github.com/YYYukiyamazakIII/kakeibo</br>
</br>
# 工夫したポイント
できるだけ手軽に出費の登録ができるようにした点です。ペルソナから洗い出した課題を解決するために、家計簿の記載にスピード感や手軽さが必要であると考えました。そのため、出費の登録は非同期通信で行い、何件も続けて登録できるようにしました。また、同じページで登録だけではなく編集、削除もできるようにしました。</br>
しかし、登録直後の出費は一度ページの更新を行わないと「編集」ボタン及び「削除」ボタンが表示されないため、間違えて登録してしまい続けて編集、削除する際は作業工程が多くなってしまいます。今後、ページの更新を行わなくて済むよう改善したいと考えています。