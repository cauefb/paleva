class Beverage < ApplicationRecord
  belongs_to :establishment

  has_one_attached :image

  validates :name, :description, :calories, presence: true
end
