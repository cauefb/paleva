require 'rails_helper'
 describe 'Quando usuário logado' do
    it "cadastra restaurante" do
      #arrange
      User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao1@gmail.com", password: "password123456")
  
      #act
      visit root_path
      #click_on "Entrar"
  
      fill_in "E-mail",	with: "joao1@gmail.com" 
      fill_in "Senha",	with: "password123456" 
      within('form') do
        click_on 'Entrar'
      end


      fill_in "Nome Fantasia",	with: "teste" 
      fill_in "Razão Social",	with: "teste" 
      fill_in "CNPJ",	with: CNPJ.generate 
      fill_in "Endereço",	with: "teste" 
      fill_in "Telefone",	with: "11999999999" 
      fill_in "E-mail",	with: "teste@teste.com" 

      click_on 'Cadastrar Restaurante'
  
      #assert
      expect(current_path).to eq("/establishments/1")  
      expect(page).to have_content 'Estabelecimento criado com sucesso.' 
    end
    it "cadastra horário de funcionamento" do
      
    end
    
 end


