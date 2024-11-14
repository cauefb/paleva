class Menu < ApplicationRecord
  
  belongs_to :establishment
  has_and_belongs_to_many :dishes
  has_and_belongs_to_many :beverages
  has_many :orders

  validates :name, presence: true, uniqueness: { scope: :establishment_id, message: "já existe no seu estabelecimento." }
end
