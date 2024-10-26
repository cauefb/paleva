require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#Valid?" do
    it "usuário válido" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")

      expect(user).to be_valid  
    end

    it "nome obrigatório" do
      user = User.new(name:"", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")

      expect(user).not_to be_valid 
    end
    it "sobrenome válido" do
      user = User.new(name:"João", last_name:"", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")

      expect(user).not_to be_valid  
    end

    it "cpf obrigatório" do
      user = User.new(name:"João", last_name:"Campos", cpf: "", email: "joao@gmail.com", password: "password123456")

      expect(user).not_to be_valid 
    end

    it "email obrigatório" do
      user = User.new(name:"João", last_name:"Campos", cpf: CPF.generate, email: "", password: "password123456")

      expect(user).not_to be_valid 
    end

    it "senha obrigatório" do
      user = User.new(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "")

      expect(user).not_to be_valid 
    end

    it "deve ser único" do
      user = User.create!(name:"João", last_name:"Campos", cpf: "98839836039", email: "joao@gmail.com", password: "password123456")
      user2 = User.new(name:"João", last_name:"Campos", cpf: "98839836039", email: "joao@gmail.com", password: "")

      expect(user2).not_to be_valid  
    end
    
  end
end

