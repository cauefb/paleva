class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :last_name, :cpf, presence: true
  validates :cpf, :email, uniqueness: true
  validate :cpf_must_be_valid       
  validates :password, length: { minimum: 12 }, if: -> { password.present? }

  def cpf_must_be_valid
    errors.add(:cpf, "é inválido") unless CPF.valid?(cpf)
  end
end
