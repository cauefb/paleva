require 'rails_helper'

describe "Usuário logado cadastra uma porção" do
  it "apartir da listagem de pratos" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)

    #act
    login_as user
    visit root_path
    click_on 'Meus Pratos'
    click_on 'Ver Mais'
    click_on 'Cadastrar Porção'
    fill_in "Descrição",	with: "1KG" 
    fill_in "Preço",	with: "35,00"  
    click_on "Enviar"

    #assert
    expect(page).to have_content 'Porção criada com sucesso.'  
  end
  
  it "a partir da listagem de bebidas" do
        #arrange
        user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
        establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
          cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
          Beverage.create!(name: 'Negroni', description: 'gim, vermute tinto e Red Bitter ', calories: '150', is_alcholic: 1, establishment: establishment)

    
        #act
        login_as user
        visit root_path
        click_on 'Minhas Bebidas'
        click_on 'Ver Mais'
        click_on 'Cadastrar Porção'
        fill_in "Descrição",	with: "Dose" 
        fill_in "Preço",	with: "35,00"  
        click_on "Enviar"
    
        #assert
        expect(page).to have_content 'Porção criada com sucesso.'  
  end
  
end
