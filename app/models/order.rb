class Order < ApplicationRecord
  belongs_to :menu
  belongs_to :establishment
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :costumer_name, presence: true

  validate :phone_or_email_present
  validate :email_must_be_valid
  validate :doc_must_be_valid

  # enum status: {
  #   draft: 0,
  #   pending: 1,
  #   preparing: 2,
  #   cancelled: 3,
  #   ready: 4,
  #   delivered: 5
  # }
  enum :status, [:draft, :pending_kitchen, :preparing, :cancelled, :ready, :delivered]

  before_validation :generate_code

  private

  def phone_or_email_present
    if costumer_phone.blank? && costumer_email.blank?
      errors.add(:base, "Pelo menos um contato deve ser preenchido (telefone ou email).")
    end
  end

  def email_must_be_valid
    email_regexp = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    unless email_regexp.match?(costumer_email)
      errors.add(:costumer_email, 'inválido') unless costumer_email.blank?
    end
  end

  def doc_must_be_valid
    unless CPF.valid?(costumer_doc)
      errors.add(:costumer_doc, 'inválido') unless costumer_doc.blank?
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
