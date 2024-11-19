class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :establishment, dependent: :destroy

  validates :name, :last_name, :cpf, presence: true
  validates :cpf, :email, uniqueness: true
  validate :cpf_must_be_valid       
  validates :password, length: { minimum: 12 }, if: -> { password.present? }

  before_create :associate_with_restaurant_if_pre_registered
  
  private

  def cpf_must_be_valid
    errors.add(:cpf, "é inválido") unless CPF.valid?(cpf)
  end

  def associate_with_restaurant_if_pre_registered
    pre_registered_user = Employee.find_by(email: email, cpf: cpf, used: false)
    if pre_registered_user
      self.establishment = pre_registered_user.establishment
      pre_registered_user.update(used: true)
    end
  end
end
