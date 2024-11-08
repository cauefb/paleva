require 'rails_helper'

describe "Usuário edita uma porção" do
  it "de bebida" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    beverage =  Beverage.create!(name: 'Suco de abacaxi', description: '100% natural', calories: '700',is_alcholic: 0, establishment: establishment)
      Portion.create!(description: '600ml', price: 800, dish: beverage )

    #act
    login_as user
    visit root_path 
    click_on 'Minhas Bebidas'
    click_on 'Ver Detalhes'
    click_on 'Editar Porção'
    fill_in "Descição",	with: "1 litro"
    fill_in "Preço",	with: "15,00"
    
    #assert
    expect(page).to have_content 'Porção editada com sucesso.'
    expect(page).to have_content '1 litro'    
    expect(page).to have_content '15,00'   

  end
  it "de prato" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
    Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )

    login_as(user)
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Ver Detalhes'
    click_on 'Editar Porção'
    fill_in "Descição",	with: "Porção Grande"
    fill_in "Preço",	with: "50,00"

    expect(page).to have_content 'Porção editada com sucesso.'
    expect(page).to have_content 'Porção Grande'    
    expect(page).to have_content '50,00'    
    
    
  end
end
