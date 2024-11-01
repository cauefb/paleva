require 'rails_helper'
describe "Usuário logado " do  
  context "cadastra nova bebida" do
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
  
      
      establishment.save
      user.establishment = establishment
      #act
      
      login_as user
      visit root_path
 
      click_on 'Cadastrar Bebida'
      fill_in "Nome",	with: "Bebida teste"
      fill_in "Descrição",	with: "Descriçao da bebida"
      fill_in "Calorias",	with: "400" 
      check('Alcoólico')   
      click_on "Salvar"  

      #assert
      expect(page).to have_content 'Bebida cadastrada com sucesso'  
      expect(page).to have_content 'Bebida teste' 
      expect(page).to have_content 'Descriçao da bebida'
      expect(page).to have_content '400' 
      expect(page).to have_content 'Sim'
   end 

  #  it "com dados faltando" do
  #   #arrange
  #   user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
  #   establishment = Establishment.new(
  #     email:'teste@gmail.com', 
  #     brand_name: 'teste', 
  #     corporate_name: 'teste LTDA', 
  #     cnpj: '56924048000140',
  #     phone: '71992594946', 
  #     address: 'Rua das Alamedas avenidas' 
  #   )
  #   opening_hour = []
  #   7.times { |i| opening_hour << OpeningHour.new(day_of_week: i, closed: true)}
  #   opening_hour <<  OpeningHour.new(
  #     day_of_week: 6,
  #     open_time: Time.zone.parse('08:00'), 
  #     close_time: Time.zone.parse('22:00'), 
  #     closed: false
  #   )

  #   establishment.opening_hours = opening_hour
  #   establishment.save
  #   user.establishment = establishment
    
  #   #act
  #   visit root_path
  #   fill_in "E-mail",	with: "joao@gmail.com" 
  #   fill_in "Senha",	with: "password123456" 
  #   within('form') do
  #     click_on 'Entrar'
  #   end
  #   click_on 'Cadastrar Novo Prato'
  #   fill_in "Nome",	with: ''
  #   fill_in "Descrição",	with: ''
  #   fill_in "Calorias",	with: ''     
  #   click_on "Salvar"  

  #   #assert
  #   expect(page).to have_content 'Nome não pode ficar em branco'  
  #   expect(page).to have_content 'Descrição não pode ficar em branco' 
  #   expect(page).to have_content 'Calorias não pode ficar em branco'
    
  #  end
   
  end 
end
