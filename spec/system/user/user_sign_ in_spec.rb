require 'rails_helper'

describe "Usuário faz login" do
  it "com sucesso" do
    #arrange
    User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")

    #act  nome sobrenome cpf e-mail senha  confirmacao de senha cadastrar
    visit root_path
    click_on "Entrar"

    fill_in "E-mail",	with: "joao@gmail.com" 
    fill_in "Senha",	with: "password123456" 
    within('form') do
      click_on 'Entrar'
    end
    

    #assert
  
    within('nav') do
            expect(page).to have_content 'joao@gmail.com'  
    end 
  end
  
  it "com dados diferentes" do
     #arrange
     User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao1@gmail.com", password: "password123456")

     #act  
     visit root_path
     click_on "Entrar"
 
     fill_in "E-mail",	with: "joaos1@gmail.com" 
     fill_in "Senha",	with: "password1234567" 
     within('form') do
       click_on 'Entrar'
     end
     
 
     #assert
     expect(page).to have_content 'E-mail ou senha inválidos.'
     
  end

  it "e faz logout" do
      #arrange
      User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")

      #act  
      visit root_path
      #click_on "Entrar"
  
      fill_in "E-mail",	with: "joao@gmail.com" 
       fill_in "Senha",	with: "password123456" 
      within('form') do
        click_on 'Entrar'
      end
      
      click_on 'Sair' 
      
      #assert
      #expect(page).to  eq new_user_session_path
      within('nav') do
        expect(page).not_to have_content 'joao@gmail.com'  
      end 
  end
  context "e não tem restaurante cadastrado" do
    it "deveria ser levado para rota de cadastro" do
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
   
       #assert
       expect(current_path).to eq(new_establishment_path)  
    end
    
  end
  
  
end