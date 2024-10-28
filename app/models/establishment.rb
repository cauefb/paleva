class Establishment < ApplicationRecord
  belongs_to :user
  has_many :opening_hours, dependent: :destroy
  
  validates :brand_name,:corporate_name, :cnpj, :address, :phone, :email, presence: true
  validates :phone, length: { in: 10..11}
  validates :user, :code, uniqueness: true
  validate :valid_cnpj

  
  before_create :generate_unique_code

  private 

  def valid_cnpj
    unless CNPJ.valid?(cnpj)
      errors.add(:cnpj, "não é válido")
    end
  end

  def generate_unique_code
    loop do
      self.code = SecureRandom.alphanumeric(6).upcase
      break unless Establishment.exists?(code: code)
    end
  end

end