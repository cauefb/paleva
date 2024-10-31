require 'rails_helper'
describe "Usuario edita estabelecimento" do
  it "faltando campos" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.new(
      email:'teste@gmail.com', 
      brand_name: 'teste', 
      corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',
      phone: '71992594946', 
      address: 'Rua das Alamedas avenidas' 
    )
    opening_hour = []
    7.times { |i| opening_hour << OpeningHour.new(day_of_week: i, closed: true)}
    opening_hour <<  OpeningHour.new(
      day_of_week: 6,
      open_time: Time.zone.parse('08:00'), 
      close_time: Time.zone.parse('22:00'), 
      closed: false
    )

    establishment.opening_hours = opening_hour
    establishment.save
    user.establishment = establishment
    #act
    visit root_path

    fill_in "E-mail",	with: "joao@gmail.com" 
    fill_in "Senha",	with: "password123456" 
    within('form') do
      click_on 'Entrar'
    end
   
    click_on 'Restaurante'
    click_on 'Editar'
    fill_in "Nome Fantasia",	with: "" 
    fill_in "Razão Social",	with: ""
    click_on 'Salvar'
    # Assert
    expect(page).to have_content 'Não foi possível atualizar o estabelecimento'  
    
  
  end 

  it "com sucesso" do
    #arrange
    user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
    establishment = Establishment.new(
      email:'teste@gmail.com', 
      brand_name: 'teste', 
      corporate_name: 'teste LTDA', 
      cnpj: '56924048000140',
      phone: '71992594946', 
      address: 'Rua das Alamedas avenidas' 
    )
    opening_hour = []
    7.times { |i| opening_hour << OpeningHour.new(day_of_week: i, closed: true)}
    opening_hour <<  OpeningHour.new(
      day_of_week: 6,
      open_time: Time.zone.parse('08:00'), 
      close_time: Time.zone.parse('22:00'), 
      closed: false
    )

    establishment.opening_hours = opening_hour
    establishment.save
    user.establishment = establishment

    #act
    visit root_path
    fill_in "E-mail",	with: "joao@gmail.com" 
    fill_in "Senha",	with: "password123456" 
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Restaurante'
    click_on 'Editar'
    fill_in "Nome Fantasia",	with: "Novo Bom Restaurante" 
    fill_in "Razão Social",	with: "Novo Bom Restaurante LTDA"
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Estabelecimento atualizado com sucesso'
  end 
end
