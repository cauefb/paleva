require 'rails_helper'

describe "Usuário deleta uma bebida cadastrada" do
  it "com sucesso" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      Beverage.create!(name: 'Negroni', description: 'gim, vermute tinto e Red Bitter ', calories: '150', is_alcholic: 1, establishment: establishment)

    #act
    login_as user
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'Ver Detalhes'
    click_on 'Remover'

    #assert
    expect(page).to have_content 'Bebida deletada com sucesso'  
  end
end
