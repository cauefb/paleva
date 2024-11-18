require 'rails_helper'

describe "Usuário visita página com a lista de funccionario cadastrados" do
  it "e vê todos" do
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
    Employee.create!(email:'funcionario1@gmail.com',cpf: CPF.generate, establishment: establishment)  
    Employee.create!(email:'funcionario2@gmail.com',cpf: CPF.generate, establishment: establishment)  
    Employee.create!(email:'funcionario3@gmail.com',cpf: CPF.generate, establishment: establishment)  


    login_as user
    visit root_path
    click_on 'Ver Usuários Cadastrados'

    expect(page).to have_content 'funcionario1@gmail.com'  
    expect(page).to have_content 'funcionario2@gmail.com'  
    expect(page).to have_content 'funcionario3@gmail.com'  
  end
  
end
