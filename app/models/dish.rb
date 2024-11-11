class Dish < ApplicationRecord
  belongs_to :establishment
  has_many :portions

  has_many :dish_tags, dependent: :destroy
  has_many :tags, through: :dish_tags
  has_and_belongs_to_many :menus

  has_one_attached :image

  validates :name, :description, :calories, presence: true
end
