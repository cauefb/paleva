class Dish < ApplicationRecord
  belongs_to :establishment
  has_many :portions

  has_one_attached :image

  validates :name, :description, :calories, presence: true
end
