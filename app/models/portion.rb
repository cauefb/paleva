class Portion < ApplicationRecord
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true
  has_many :portion_price_histories
  
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  validate :must_belong_to_dish_or_beverage

  before_save :convert_price_to_integer
  after_update :save_price_history, if: :price_changed?

  private

  def must_belong_to_dish_or_beverage
    unless dish.present? || beverage.present?
      errors.add(:base, "Porção deve estar associada a um prato ou a uma bebida.")
    end
  end

  def convert_price_to_integer
    if price.is_a?(String)
      # Substitui vírgula por ponto, converte para float, multiplica por 100 e converte para inteiro
      self.price = (price.gsub(',', '.').to_f * 100).to_i
    end
  end

  def save_price_history
    portion_price_histories.create(price: price_was, date: Date.today)
  end
end
