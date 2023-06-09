class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sale
  belongs_to :shopping
  belongs_to :prefecture
  belongs_to :shopping_day

  validates :name, :content, :image, :price, presence: true
  validates :category_id, :sale_id, :shopping_id, :prefecture_id, :shopping_day_id,
            numericality: { other_than: 1, message: "は空では登録できません" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
