require 'rails_helper'

describe "Order API" do
  context "/api/v1/establishments/establishment_code/orders" do
    it "sucesso" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
      portion = Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
      menu = Menu.create!(
        name: "Menu do Dia", establishment: establishment
      )
      menu.dishes << dish
      order_1 = Order.create!(menu: menu, establishment: establishment, costumer_name: 'Claudio Manoel', costumer_email: 'claudio@email.com')
      order_2 = Order.create!(menu: menu,establishment: establishment, costumer_name: 'Marta', costumer_email: 'marta@email.com')
      order_2.pending_kitchen!


      get api_v1_establishment_orders_path(establishment.code), params: {status: "pending_kitchen" }
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response.class).to eq Array
      expect(json_response.first["status"]).to eq "pending_kitchen"
      expect(json_response.length).to eq 1
    end   
    
    it "estabelecimento não existe" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)

      get api_v1_establishment_orders_path('GHSUEOD')
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(404)
    end
    it "sem filto de status retorna todos os pedidos" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
      portion = Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
      menu = Menu.create!(
        name: "Menu do Dia", establishment: establishment
      )
      menu.dishes << dish
      order_1 = Order.create!(menu: menu, establishment: establishment, costumer_name: 'Claudio Manoel', costumer_email: 'claudio@email.com')
      order_2 = Order.create!(menu: menu,establishment: establishment, costumer_name: 'Marta', costumer_email: 'marta@email.com')
      order_3 = Order.create!(menu: menu,establishment: establishment, costumer_name: 'Carlos', costumer_email: 'carlos@email.com')
      order_4 = Order.create!(menu: menu,establishment: establishment, costumer_name: 'Marcos', costumer_email: 'marcos@email.com')
      order_1.pending_kitchen!
      order_2.pending_kitchen!
      order_3.pending_kitchen!
      order_4.pending_kitchen!


      get api_v1_establishment_orders_path(establishment.code)
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response.class).to eq Array
      expect(json_response.first["status"]).to eq "pending_kitchen"
      expect(json_response.length).to eq 4
    end
  end
end
