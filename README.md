# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| encrypted_password | string              | null: false               |
| email              | string              | null: false, unique: true |
| first_name         | string              | null: false               |
| family_name        | string              | null: false               |
| first_name_kana    | string              | null: false               |
| family_name_kana   | string              | null: false               |
| birthday           | date                | null: false               |

### Association

- has_many :products
- has_many :purchases

## products table

| Column             | Type                | Options                       |
|--------------------|---------------------|-------------------------------|
| name               | string              | null: false                   |
| explanation        | text                | null: false                   |
| category_id        | integer             | null: false                   |
| derively_fee_id    | integer             | null: false                   |
| status_id          | integer             | null: false                   |
| prefecture_id      | integer             | null: false                   |
| scheduled_day_id   | integer             | null: false                   |
| price              | integer             | null: false                   |
| user               | references          | null: false, foreign_key:true |


### Association

- belongs_to :user 
- has_one :purchase

##  　purchases　table

| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| user        | references | null: false, foreign_key: true |
| product     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :address


## addresses table

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipality       | string     | null: false                    |
| address            | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| user               | references | null: false, foreign_key: true |
| product            | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase