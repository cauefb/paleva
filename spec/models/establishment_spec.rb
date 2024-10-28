require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe " cadastra restaurante" do
    it "gera código aleátorio" do
      # Arrange
      user = User.create!(name: 'Carlos', last_name: 'Jonas', cpf: CPF.generate, email: 'carlosjonas@email.com', password: '1234567891011')
      establishment = Establishment.create!(corporate_name: 'Carloss LTDA', brand_name: "Carlos's Cafe", address: '123 Main St', user: user, cnpj: '33.113.309/0001-47', 
                                            email: 'carlosjonas@email.com', phone: '99999043113')
      # Act

      # Assert
      expect(establishment.code).not_to be_empty
      expect(establishment.code.length).to eq 6                                         
    end
    
  end
  
end
