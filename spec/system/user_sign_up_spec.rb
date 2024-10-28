require 'rails_helper'

describe "Usuário se cadastra" do
  it "com sucesso" do
    #arrange
    
    #act  nome sobrenome cpf e-mail senha  confirmacao de senha cadastrar
    visit root_path
    click_on "Entrar"
    click_on "Criar uma conta"
    fill_in "Nome",	with: 'João'
    fill_in "Sobrenome",	with: "Campos"  
    fill_in "CPF",	with: CPF.generate 
    fill_in "E-mail",	with: "joao1@gmail.com" 
    fill_in "Senha",	with: "password123456"
    fill_in "Confirme sua senha",	with: "password123456"  
    click_on 'Criar Conta'
    #assert
    expect(page).to have_content 'Você precisa cadastrar um restaurante antes de continuar.'  
    expect(current_path).to eq(new_establishment_path)  
  end
  
end

