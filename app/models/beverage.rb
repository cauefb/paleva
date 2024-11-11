class Beverage < ApplicationRecord
  belongs_to :establishment
  has_many :portions

  has_one_attached :image
  has_and_belongs_to_many :menus

  validates :name, :description, :calories, presence: true
end
