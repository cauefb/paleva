require 'rails_helper'
 describe 'Quando usuário logado' do
    it "cadastra restaurante" do
      #arrange
      User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
  
      #act
      visit root_path
      #click_on "Entrar"
  
      fill_in "E-mail",	with: "joao@gmail.com" 
      fill_in "Senha",	with: "password123456" 
      within('form') do
        click_on 'Entrar'
      end


      fill_in "Nome Fantasia",	with: "teste" 
      fill_in "Razão Social",	with: "teste" 
      fill_in "CNPJ",	with: CNPJ.generate 
      fill_in "Endereço",	with: "teste" 
      fill_in "Telefone",	with: "11999999999" 
      fill_in "E-mail",	with: "teste@teste.com" 

      days_of_week = %w[domingo segunda-feira terça-feira quarta-feira quinta-feira sexta-feira sábado]
    
      days_of_week.each do |day|
        # Encontra o dia pelo ID definido na div
        within("div##{day.downcase}") do
          fill_in 'Horário de Abertura', with: '08:00'
          fill_in 'Horário de Fechamento', with: '18:00'
          uncheck 'Fechado' # Desmarcando "Fechado" se for um dia de funcionamento normal
        end
      end
      
      

      click_on 'Salvar'
  
      #assert
      expect(current_path).to eq("/establishments/1")  
      expect(page).to have_content 'Estabelecimento criado com sucesso.' 
    end
    it "cadastra horário de funcionamento" do
      
    end
    
 end


