describe "Usuário se cadastra" do
  it "com sucesso" do
    #arrange
    User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")

    #act  nome sobrenome cpf e-mail senha  confirmacao de senha cadastrar
    visit root_path
    click_on "Entrar"

    fill_in "E-mail",	with: "joao@gmail.com" 
    fill_in "Senha",	with: "password123456"
    fill_in "Confirme sua senha",	with: "password123456"  
    click_on 'Entrar'

    #assert
    expect(page).not_to have_link 'Entrar'
    within('nav') do
            expect(page).to have_content 'joao@gmail.com'  
    end 
  end
  
end