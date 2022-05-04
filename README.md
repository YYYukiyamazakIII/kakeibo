# テーブル設計

## expenses テーブル

| Colum       | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     |                                |
| value       | integer    | null: false                    |
| category_id | integer    |                                |
| user_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## users テーブル

| Colum         | Type    | Options                   |
| ------------- | ------- | ------------------------- |
| name          | string  | null: false               |
| mail_address  | string  | null: false, unique: true |
| password      | string  | null: false               |
| prefecture_id | integer |                           |
| city          | string  |                           |
| text          | text    |                           |

### Association

- has_many :expenses
- has_many :tweets
- has_many :comments
- has_many :nices

## tweets テーブル

| Colum   | Type       | Options                        |
| ------- | ---------  | ------------------------------ |
| text    | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :nices

## comments テーブル

| Colum    | Type       | Options                        |
| -------- | ---------  | ------------------------------ |
| text     | text       | null: false                    |
| user_id  | references | null: false, foreign_key: true |
| tweet_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :tweet

## nices テーブル

| Colum    | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user_id  | references | null: false, foreign_key: true |
| tweet_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :tweet