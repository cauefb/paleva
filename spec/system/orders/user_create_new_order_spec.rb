require 'rails_helper'

describe "Usuário faz um pedido" do
  it "com sucesso" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
    portion = Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
    menu = Menu.create!(
      name: "Menu do Dia", establishment: establishment
    )
    menu.dishes << dish

    login_as user
    visit root_path

    click_on 'Criar Pedido'
    fill_in "Nome do Cliente",	with: "Fabio Santana"
    fill_in "Telefone do Cliente",	with: "11953156487"
    fill_in "E-mail do Cliente",	with: "fabio@gmail.com" 
    click_on 'Iniciar Pedido'
    click_on 'Selecionar Porções'
    choose("portion_#{portion.id}")
    click_on 'Adicionar ao Pedido'
    click_on 'Finalizar Pedido'

    expect(page).to have_content 'Pedido efetuado com sucesso!'  

  end
  
  it "e tenta finalizar sem item" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
    portion = Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
    menu = Menu.create!(
      name: "Menu do Dia", establishment: establishment
    )
    menu.dishes << dish

    login_as user
    visit root_path

    click_on 'Criar Pedido'
    fill_in "Nome do Cliente",	with: "Fabio Santana"
    fill_in "Telefone do Cliente",	with: "11953156487"
    fill_in "E-mail do Cliente",	with: "fabio@gmail.com" 
    click_on 'Iniciar Pedido'
    click_on 'Selecionar Porções'
    choose("portion_#{portion.id}")
    click_on 'Adicionar ao Pedido'
    click_on 'Remover Item'
    click_on 'Finalizar Pedido'

    expect(page).to have_content 'Não é possível finalizar o pedido sem itens.'  

  end
end
