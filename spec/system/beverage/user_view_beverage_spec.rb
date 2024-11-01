require 'rails_helper'
describe "Usuário vê todas as bebidas cadastrados" do
  it "com sucesso" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
     Beverage.create!(name: 'Negroni', description: 'teste', calories: '10',is_alcholic: 1, establishment: establishment)
     Beverage.create!(name: 'Suco de laranja', description: '100% natural', calories: '100',is_alcholic: 0, establishment: establishment)
     Beverage.create!(name: 'Suco de abacaxi', description: '100% natural', calories: '700',is_alcholic: 0, establishment: establishment)

    #act
    login_as user
    visit root_path
    click_on 'Minhas Bebidas'

    #assert
    expect(page).to have_content 'Negroni' 
    expect(page).to have_content 'Suco de laranja'  
    expect(page).to have_content 'Suco de abacaxi'  
  end
end
