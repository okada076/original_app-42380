
## アプリケーシション
初心者向けの家庭菜園アプリ

## アプリケーション概要
このオリジナルアプリは、「家庭菜園を始めたけれど、何から始めればいいのか分からない」「これで合っているのか不安」
と感じる初心者のための、野菜の育成記録や、他のユーザーとの工夫・失敗の共有ができるSNS型サポートアプリです。


## URL
https://◎◎◎◎.onrender.com
<br>※デプロイ済みのURLを記載。デプロイが済んでいない場合は、デプロイが完了次第記載すること。

## テスト用アカウント
テスト用Email：test@test.com
<br>テスト用Password：aaa123
<br>※ログイン機能等を実装した場合は、ログインに必要な情報を記載。
<br>Basic認証 ID:admin  PASS:1111

## 利用方法
1. URLにアクセスし、ヘッダー右上の「ログイン」ボタンからログイン画面に移動します。
2. テスト用アカウントを使用しログインします。
3. トップページのヘッダー右上の「投稿する」ボタンから新規呟きを投稿します。
4. 投稿内容には画像1枚と文章を含めることができます。
5. 他のユーザーの呟きを閲覧し、コメントを残すことも可能です。
6. 投稿した呟きはトップページから編集・削除できます。

## アプリケーションを作成した背景
私自身が家庭菜園を趣味として始めた際に、インターネットや書籍で得られる情報が豊富である一方、「自分のやり方で本当に合っているのか」「失敗したけれど、これはよくあることなのか」といった不安を抱えることがありました。プロや経験者の情報は参考になる一方で、かえってハードルの高さを感じることもありました。
その経験から、初心者が初心者同士で気軽に育成記録や失敗・工夫を共有し合える場の必要性を強く感じました。ただ育てるだけでなく、「育てている過程を安心して見せ合える」「仲間がいると感じられる」仕組みを通して、より楽しく・継続しやすい家庭菜園の環境を提供したいと考えました。



## 実装した機能についての画像やGIFおよびその説明
|ページ|説明|
|---|------------------|
|![トップページのGIF](URL_TO_GIF)|トップページ　　　　　　　　　　　　　　　　　　　　　　|
|![ユーザー機能のGIF](URL_TO_GIF)|ユーザー機能<br>・新規登録<br>・ログイン/ログアウト<br>・マイページ|
|![ツイート機能のGIF](URL_TO_GIF)|ツイート（呟き）機能<br>・投稿機能<br>・一覧機能<br>・詳細機能<br>・編集・削除機能|
|![コメント機能のGIF](URL_TO_GIF)|コメント機能|
|![検索機能のGIF](URL_TO_GIF)|検索機能|

## 実装予定の機能
- リアルタイム通知機能
- ユーザー同士のフォロー機能
- お気に入りのツイートを保存する機能
- 高度な検索フィルター機能

## データベース設計
ER図を添付。
<br>AIで作る場合は、googleアカウントがあれば使用できる「Vercel v0」がオススメです。
<img width="307" alt="Image" src="https://github.com/user-attachments/assets/f780ed7f-e22c-495f-ad7d-5add7f75e45f" />


## 画面遷移図
画面遷移図を添付。
<br>AIで作る場合は、googleアカウントがあれば使用できる「Vercel v0」がオススメです。
<img width="509" alt="Image" src="https://github.com/user-attachments/assets/086ceb82-5286-4340-b4ff-014d621e4d26" />


## 開発環境
| 項目               | バージョン・サービス |
|------------------|-----------------|
| **言語**        | Ruby 3.2.0 |
| **フレームワーク** | Ruby on Rails 7.1.5.1 |
| **データベース**  | PostgreSQL 14.15（本番） / MySQL 8.0（開発） |
| **フロントエンド** | HTML / CSS / JavaScript |
| **認証機能**    | Devise |
| **デプロイ環境** | Render |
| **バージョン管理** | GitHub |

## ローカルでの動作方法

1. リポジトリをクローンします。
```ruby
  git clone https://github.com/okada076/original_app-42380
```

2.必要なGemをインストールします。
  ```ruby
  bundle install 
  ```
3.データベースを設定します。
  ```ruby
  rails db:create
  rails db:migrate
  ```
4.アプリケーションを起動します。
  ```ruby
  rails s
  ```
5.ブラウザで http://localhost:3000 にアクセスします。


## 工夫したポイント
PicTweetは、誰でも簡単に使えるようにデザインされています。特に以下の点に工夫しました。
<br> - 簡単な画像アップロード：投稿の際に画像をすぐにアップロードできます。
<br> - 直感的なインターフェース：操作がしやすく、初めての人でもわかりやすいデザインにしています。

## 今後の課題
現在のアプリは基本的な機能を提供していますが、ユーザーのニーズに応えるために、以下の追加機能を検討しています。

<br>コメント機能の編集・削除：投稿したコメントの内容を変更したり、削除できるようにします。
<br>画像の複数アップロード：複数の画像を一度に投稿できる機能を追加します。

## 制作時間
200時間



# テーブル設計

## users テーブル

| Column             | Type   | Options                           |
|--------------------|--------|-----------------------------------|
| nickname           | string | null: false                       |
| email              | string | null: false, unique: true         |
| encrypted_password | string | null: false                       |

### Association
- has_many :posts
- has_many :comments
- has_many :likes

---

## posts テーブル

| Column       | Type       | Options                             | 説明                         |
|--------------|------------|--------------------------------------|------------------------------|
| title        | string     | null: false                         | 投稿のタイトル               |
| content      | text       | null: false                         | 投稿の本文                   |
| image        | string     | null: false                         | 画像（1枚必須）              |
| category     | integer    | null: false                         | enumで育成記録/つまずきノート |
| vegetable_id | integer    | null: false, foreign_key: true      | 紐づく野菜                   |
| user_id      | references | null: false, foreign_key: true      | 投稿者                       |

### Association
- belongs_to :user
- belongs_to :vegetable
- has_many :comments
- has_many :likes
- has_many :post_tags
- has_many :tags, through: :post_tags

---

## comments テーブル

| Column   | Type       | Options                          |
|----------|------------|----------------------------------|
| text     | text       | null: false                      |
| user_id  | references | null: false, foreign_key: true   |
| post_id  | references | null: false, foreign_key: true   |

### Association
- belongs_to :user
- belongs_to :post

---

## likes テーブル

| Column   | Type       | Options                          |
|----------|------------|----------------------------------|
| user_id  | references | null: false, foreign_key: true   |
| post_id  | references | null: false, foreign_key: true   |

### Association
- belongs_to :user
- belongs_to :post

---

## tags テーブル

| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :post_tags
- has_many :posts, through: :post_tags

---

## post_tags テーブル（中間テーブル）

| Column   | Type       | Options                          |
|----------|------------|----------------------------------|
| post_id  | references | null: false, foreign_key: true   |
| tag_id   | references | null: false, foreign_key: true   |

### Association
- belongs_to :post
- belongs_to :tag

---

## vegetables テーブル

| Column | Type   | Options     |
|--------|--------|-------------|
| name   | string | null: false |

### Association
- has_many :posts
- has_many :growing_steps

---

## growing_steps テーブル

| Column        | Type       | Options                          | 説明        |
|---------------|------------|----------------------------------|-------------|
| title         | string     | null: false                     | ステップ名  |
| content       | text       | null: false                     | 内容        |
| step_number   | integer    | null: false                     | 表示順      |
| vegetable_id  | references | null: false, foreign_key: true | 紐づく野菜  |

### Association
- belongs_to :vegetable