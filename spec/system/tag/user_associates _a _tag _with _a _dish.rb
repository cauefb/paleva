require 'rails_helper'

describe "Usuário logado associa tag a um prato" do
  it "com sucesso" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)      
    Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
    Tag.create!(name:"apimentado")
    Tag.create!(name:"vegano")
    Tag.create!(name:"massa")

    login_as(user)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Ver Detalhes'
    select 'massa', from: 'Adicionar Tag' 
    click_on 'Adicionar Tag'

    expect(page).to have_content 'Tag adicionada com sucesso!'  
    expect(page).to have_content 'massa'  
  end
  
end
