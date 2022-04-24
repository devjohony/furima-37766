class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :scheduled_day
  belongs_to_active_hash :derively_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  has_one_attached :image

  belongs_to :user
  # has_one    :purchase

  with_options presence: true do
    validates :image
    validates :name
    validates :explanation
    validates :category_id
    validates :derively_fee_id
    validates :status_id
    validates :prefecture_id
    validates :scheduled_day_id
    validates :price
  end

  with_options numericality: { other_than: 0, message: 'select' } do
    validates :category_id
    validates :scheduled_day_id
    validates :derively_fee_id
    validates :prefecture_id
    validates :status_id
  end

  validates :price, format: { with: /\A[0-9]+\z/, message: 'Price Half-width number' }, inclusion: { in: (300..9_999_999), message: 'Out of setting range' }

end
