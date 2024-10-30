require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe "Cadastra restaurante" do
    it "gera código aleátorio" do
      # Arrange
      user = User.create!(name: 'Teste', last_name: 'Teste', cpf: CPF.generate, email: 'teste@email.com', password: '1234567891011')
      establishment = Establishment.create!(corporate_name: 'Teste LTDA', brand_name: "Teste Cafe", address: 'Rua teste 123', user: user, cnpj: '33.113.309/0001-47', 
                                            email: 'Josejonas@email.com', phone: '99999043113')
      # Act

      # Assert
      expect(establishment.code).not_to be_empty
      expect(establishment.code.length).to eq 6                                         
    end
    it "sem corporate name" do

      user = User.create!(name: 'Jose', last_name: 'Jonas', cpf: CPF.generate, email: 'Josejonas@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: '', brand_name: "Jose's Cafe", address: '123 Main St', user: user, cnpj: CNPJ.generate, 
                                            email: 'teste@email.com', phone: '99999043113')

      expect(establishment).not_to be_valid  
    end
    
    it "sem corporate name" do
      
      user = User.create!(name: 'Jose', last_name: 'Jonas', cpf: CPF.generate, email: 'Josejonas@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: '', brand_name: "Teste teste", address: 'Rua Teste, 123', user: user, cnpj: CNPJ.generate, 
                                            email: 'teste@email.com', phone: '99999043113')

      expect(establishment).not_to be_valid  
    end

    it "sem brandname" do
      user = User.create!(name: 'Teste', last_name: 'Teste', cpf: CPF.generate, email: 'teste@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: 'Teste LTDA', brand_name: "", address: 'Rua teste 123', user: user, cnpj: '33.113.309/0001-47', 
                                            email: 'Josejonas@email.com', phone: '99999043113')
      
      expect(establishment).not_to be_valid                                       
    end
    
    it "sem endereço" do
      user = User.create!(name: 'Teste', last_name: 'Teste', cpf: CPF.generate, email: 'teste@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: 'Teste LTDA', brand_name: "Teste", address: '', user: user, cnpj: '33.113.309/0001-47', 
                                            email: 'Josejonas@email.com', phone: '99999043113')
      
      expect(establishment).not_to be_valid                                       
    end

    it "sem CNPJ" do
      user = User.create!(name: 'Teste', last_name: 'Teste', cpf: CPF.generate, email: 'teste@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: 'Teste LTDA', brand_name: "Teste", address: 'Rua teste 123', user: user, cnpj: '', 
                                            email: 'Josejonas@email.com', phone: '99999043113')
      
      expect(establishment).not_to be_valid                                       
    end

    it "sem E-mail" do
      user = User.create!(name: 'Teste', last_name: 'Teste', cpf: CPF.generate, email: 'teste@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: 'Teste LTDA', brand_name: "Teste", address: 'Rua teste 123', user: user, cnpj: '33.113.309/0001-47', 
                                            email: '', phone: '99999043113')
      
      expect(establishment).not_to be_valid                                       
    end

    it "sem telefone" do
      user = User.create!(name: 'Teste', last_name: 'Teste', cpf: CPF.generate, email: 'teste@email.com', password: '1234567891011')
      establishment = Establishment.new(corporate_name: 'Teste LTDA', brand_name: "Teste", address: 'Rua teste 123', user: user, cnpj: CNPJ.generate, 
                                            email: 'josejonas@email.com', phone: '')
      
      expect(establishment).not_to be_valid                                       
    end
  end
end
