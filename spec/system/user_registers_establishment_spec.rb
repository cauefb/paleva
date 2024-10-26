require 'rails_helper'
 describe 'Quando usuário logado' do
  context "e não tem restaurante cadastrado" do
    it "deveria ver página de cadastro de restaurante" do
      #arrange
      User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao1@gmail.com", password: "password123456")
  
      #act
      visit root_path
      click_on "Entrar"
  
      fill_in "E-mail",	with: "joao@gmail.com" 
      fill_in "Senha",	with: "password123456" 
      within('form') do
        click_on 'Entrar'
      end
  
      #assert
      expect(current_path).to eq(new_estableshid_path)  
    end
  end  
 end