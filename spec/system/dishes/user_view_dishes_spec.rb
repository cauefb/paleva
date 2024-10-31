require 'rails_helper'
describe "Usuário vê os pratos cadastrados" do
  it "com sucesso" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    dish1 = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
    dish2 = Dish.create!(name: 'Macarrão', description: 'Bolonhesa', calories: '600', establishment: establishment)
    dish3 = Dish.create!(name: 'Risoto', description: 'com muito camarrão', calories: '700', establishment: establishment)

    #act
    visit root_path
    fill_in "E-mail",	with: "joao@gmail.com" 
    fill_in "Senha",	with: "password123456" 
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Meus Pratos'
    #assert
    expect(page).to have_content 'Lasanha' 
    expect(page).to have_content 'Bolonhesa'  
    expect(page).to have_content '400'  
  end
end
