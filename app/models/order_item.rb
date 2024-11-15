class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :portion
  #belongs_to :item, polymorphic: true
end
