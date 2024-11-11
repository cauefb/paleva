require 'rails_helper'

describe "Usuário cadastra um menu" do
  it "com sucesso" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
    Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )

    login_as user
    visit root_path
    click_on 'Cadastar Cardápio'
    fill_in "Nome",	with: "Almoço" 
    find("select[multiple]", id: "menu_dish_ids").select("Lasanha")
    click_on 'Criar Cardápio'

    expect(page).to have_content 'Cardápio criado com sucesso.'  
    expect(page).to have_content 'Lasanha'  
  end
  
end
