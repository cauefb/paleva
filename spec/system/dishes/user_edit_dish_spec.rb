require 'rails_helper'
describe "Usuário edita um prato" do
  it "com sucesso" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)

    #act
    visit root_path
    fill_in "E-mail",	with: "joao@gmail.com" 
    fill_in "Senha",	with: "password123456" 
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Meus Pratos'
    click_on 'Ver Detalhes'
    click_on 'Editar prato'
    fill_in "Nome",	with: "Lasanha bolonhesa"
    fill_in "Descrição",	with: "lasanha bolonhessa com muito queijo"  
    click_on 'Salvar'

    #assert
    expect(page).to have_content 'Prato atualizado com sucesso' 
    expect(page).to have_content 'Lasanha bolonhesa'  
    expect(page).to have_content 'lasanha bolonhessa com muito queijo' 
  end
  
  
end
