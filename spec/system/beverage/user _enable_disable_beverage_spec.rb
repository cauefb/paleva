require 'rails_helper'

describe "Usuário logado" do
  it "vê botão de desativer na tela de detalhes" do
       #arrange
       user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
       establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
         cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
         Beverage.create!(name: 'Suco de abacaxi', description: '100% natural', calories: '700',is_alcholic: 0, establishment: establishment)
   
       #act
       login_as user
       visit root_path 
       click_on 'Minhas Bebidas'
       click_on 'Ver Detalhes'
       
       #assert
       expect(page).to have_button 'Desativar'
  end

  it "desativa uma bebida" do
     #arrange
     user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
     establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
       cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
       Beverage.create!(name: 'Suco de abacaxi', description: '100% natural', calories: '700',is_alcholic: 0, establishment: establishment)
 
     #act
     login_as user
     visit root_path 
     click_on 'Minhas Bebidas'
     click_on 'Ver Detalhes'
     click_on 'Desativar'
     
     #assert
     expect(page).to have_button 'Ativar'
  end
  
  it "ativa um prato" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      Beverage.create!(name: 'Suco de abacaxi', description: '100% natural', calories: '700',is_alcholic: 0, establishment: establishment)

    #act
    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on 'Ver Detalhes'
    click_on 'Desativar'
    click_on 'Ativar'
    
    #assert
    expect(page).to have_button 'Desativar'
 end
 it "vê status do prato na tela de listagem" do
  user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
  establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
    cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)

  #act
  login_as user
  visit root_path 
  click_on 'Meus Pratos'

  
  #assert
  expect(page).to have_content 'Ativo'
  
 end
 
end
