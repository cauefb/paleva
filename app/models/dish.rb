class Dish < ApplicationRecord
  belongs_to :establishment
  validates :name, :description, :calories, presence: true
end
