require 'rails_helper'

describe "Usuáro cria funcionario" do
  it "com sucesso" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)

      login_as user
      visit root_path
      click_on 'Cadastrar Novos Usuários'
      fill_in "Email",	with: "novofuncionario@gmail.com" 
      fill_in "CPF",	with: CPF.generate
      click_on 'Cadastrar'

      expect(page).to have_content 'Usuário pré-cadastrado com sucesso.'
      expect(page).to have_content 'novofuncionario@gmail.com'   
  end
  
  it "faltando dados" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)

      login_as user
      visit root_path
      click_on 'Cadastrar Novos Usuários'
      fill_in "Email",	with: '' 
      fill_in "CPF",	with: ''
      click_on 'Cadastrar'

      expect(page).to have_content 'Cpf não pode ficar em branco'
      expect(page).to have_content 'Email não pode ficar em branco'   
  end
  
  
end
