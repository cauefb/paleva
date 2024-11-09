require 'rails_helper'

describe "Usuaário logado " do
  it "cria uma nova tag" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)

    login_as(user)
    visit root_path
    click_on 'Tags'
    fill_in "Nome da Tag",	with: "prato apimentado" 
    click_on 'Criar Tag'

    expect(page).to have_content 'Tag criada com sucesso.'
    expect(page).to have_content 'prato apimentado'  

  end 
  
  it "vê uma lista de tags criadas" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    Tag.create!(name:"apimentado")
    Tag.create!(name:"vegano")
    Tag.create!(name:"massa")

    login_as(user)
    visit root_path
    click_on 'Tags'

    expect(page).to have_content 'vegano'
    expect(page).to have_content 'apimentado'  
    expect(page).to have_content 'massa'  

  end
  
end
