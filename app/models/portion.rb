class Portion < ApplicationRecord
  belongs_to :dish
  belongs_to :beverage
end
