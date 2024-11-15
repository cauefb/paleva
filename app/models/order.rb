class Order < ApplicationRecord
  belongs_to :menu
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items
end
