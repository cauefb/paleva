require 'rails_helper'

describe "Order API" do
  context "/api/v1/establishments/establishment_code/orders" do
    it "sucesso" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
       Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
      menu = Menu.create!(
        name: "Menu do Dia", establishment: establishment
      )
      menu.dishes << dish
       Order.create!(menu: menu, establishment: establishment, costumer_name: 'Claudio Manoel', costumer_email: 'claudio@email.com')
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
       Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)

      get api_v1_establishment_orders_path('GHSUEOD')
       JSON.parse(response.body)

      expect(response).to have_http_status(404)
    end
    it "sem filto de status retorna todos os pedidos" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
      dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
      Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
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

  context 'GET /api/v1/establishments/establishment_code/orders/order_id' do
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
      allow(SecureRandom).to receive(:alphanumeric).and_return("OXPDJZJ4")    
      order_1.pending_kitchen!
      OrderItem.create!(
        order: order_1, portion: portion, quantity: 1, observation: "Porção Pequena",
        item_name: "Lasanha", unit_price: 3500
      )
      get api_v1_establishment_order_path(establishment.code, order_1.code)
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      expect(json_response["items"].class).to eq Array
      expect(json_response["status"]).to eq "pending_kitchen"
      expect(json_response["code"]).to eq "OXPDJZJ4"
      expect(json_response["items"][0]["name"]).to eq "Lasanha"
      expect(json_response["items"][0]["observation"]).to eq "Porção Pequena"
    end
    it "falha se pedido não existir" do
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
      order_1.pending_kitchen!
      OrderItem.create!(
        order: order_1, portion: portion, quantity: 1, observation: "Porção Pequena",
        item_name: "Lasanha", unit_price: 3500
      )
      
      get api_v1_establishment_order_path(establishment.code, "OJFDKEMES")

      expect(response).to have_http_status(404)
    end
    
  end

  context "/api/v1/establishments/establishment_code/orders/code_id/preparing" do
    it "sucesso" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
        allow(SecureRandom).to receive(:alphanumeric).and_return("ABC123")
      dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
      portion = Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
      menu = Menu.create!(
        name: "Menu do Dia", establishment: establishment
      )
      menu.dishes << dish
      order_1 = Order.create!(menu: menu, establishment: establishment, costumer_name: 'Claudio Manoel', costumer_email: 'claudio@email.com')
      allow(SecureRandom).to receive(:alphanumeric).and_return("OIJDE4RT")    
      order_1.pending_kitchen!
      OrderItem.create!(
        order: order_1, portion: portion, quantity: 1, observation: "Porção Pequena",
        item_name: "Lasanha", unit_price: 3500
      )
     
      patch "/api/v1/establishments/#{establishment.code}/orders/#{order_1.code}/accept"

      expect(response).to have_http_status 200
      order_1.reload
      expect(order_1).to be_preparing    
    end 

    it "pedido não existe" do
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
      order_1.pending_kitchen!
      OrderItem.create!(
        order: order_1, portion: portion, quantity: 1, observation: "Porção Pequena",
        item_name: "Lasanha", unit_price: 3500
      )
     
      patch "/api/v1/establishments/#{establishment.code}/orders/ABCD1234/accept"

      expect(response).to have_http_status 404
    end 
  end
  
  context "/api/v1/establishments/establishment_code/orders/code_id/ready" do
    it "sucesso" do
      user = User.create!(name:"João", last_name:"Campos", cpf: CPF.generate, email: "joao@gmail.com", password: "password123456")
      establishment = Establishment.create!(email:'teste@gmail.com', brand_name: 'teste', corporate_name: 'teste LTDA', 
        cnpj: '56924048000140',phone: '71992594946', address: 'Rua das Alamedas avenidas', user: user)
        allow(SecureRandom).to receive(:alphanumeric).and_return("ABC123")
      dish = Dish.create!(name: 'Lasanha', description: 'Bolonhesa', calories: '400', establishment: establishment)
      portion = Portion.create!(description: 'Porção Pequena', price: 3500, dish: dish )
      menu = Menu.create!(
        name: "Menu do Dia", establishment: establishment
      )
      menu.dishes << dish
      order_1 = Order.create!(menu: menu, establishment: establishment, costumer_name: 'Claudio Manoel', costumer_email: 'claudio@email.com')
      allow(SecureRandom).to receive(:alphanumeric).and_return("OIJDE4RT")    
      order_1.pending_kitchen!
      OrderItem.create!(
        order: order_1, portion: portion, quantity: 1, observation: "Porção Pequena",
        item_name: "Lasanha", unit_price: 3500
      )
     
      patch "/api/v1/establishments/#{establishment.code}/orders/#{order_1.code}/ready"

      expect(response).to have_http_status 200
      order_1.reload
      expect(order_1).to be_ready   
    end 
    it "pedido não existe" do
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
      order_1.pending_kitchen!
      OrderItem.create!(
        order: order_1, portion: portion, quantity: 1, observation: "Porção Pequena",
        item_name: "Lasanha", unit_price: 3500
      )
     
      patch "/api/v1/establishments/#{establishment.code}/orders/ABCD1234/ready"

      expect(response).to have_http_status 404
    end 
  end
  
end
