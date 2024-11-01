require 'rails_helper'
describe "Usuário edita uma bebida" do
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
    click_on 'Editar bebida'
    fill_in "Nome",	with: 'Negroni especial'
    fill_in "Descrição",	with: 'gim, vermute tinto, Red Bitter e gelo'  
    click_on 'Salvar'

    #assert
    expect(page).to have_content 'Bebida atualizada com sucesso' 
    expect(page).to have_content 'Negroni especial'
    expect(page).to have_content 'gim, vermute tinto, Red Bitter e gelo' 
  end
  
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
    click_on 'Editar bebida'
    fill_in "Nome",	with: 'Negroni especial'
    fill_in "Descrição",	with: 'gim, vermute tinto, Red Bitter e gelo'  
    click_on 'Salvar'

    #assert
    expect(page).to have_content 'Bebida atualizada com sucesso' 
    expect(page).to have_content 'Negroni especial'
    expect(page).to have_content 'gim, vermute tinto, Red Bitter e gelo' 
  end
  
end
