require 'rails_helper'

describe "Usuario pesquisa pratos e bebidas" do
  it "e localiza" do
     #arrange
     user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
     establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
       cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
       Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
 
     #act
     login_as user
     visit root_path
     fill_in "Busca",	with: "Lasanha"  
     click_on "Buscar"

     #assert
     expect(page).to have_content 'Lasanha'  
    
  end
  
  it 'e não está autenticado' do
    # Arrange

    # Act
    visit root_path
    # Assert
    expect(page).not_to have_content("Buscar")
  end

  it "e não localiza nenhuma bebida ou prato" do
      #arrange
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
        Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
  
      #act
      login_as user
      visit root_path
      fill_in "Busca",	with: "Macarronada"  
      click_on "Buscar"
 
      #assert
      expect(page).to have_content 'Nenhum item encontrado.'  
  end
  
  
end
