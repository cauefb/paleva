class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_establishment
  before_action :set_order, only: [:select_items, :add_item]
  def show
    @order = Order.find(params[:id])
  end
  def new
    @establishment = current_user.establishment
    @menu = @establishment.menus.find_by(id: params[:menu_id]) # Certifique-se de passar o menu_id na URL
    @order = @menu.orders.build
  end
  
  def select_items
    @dishes = Dish.all.includes(:portions)
    @beverages = Beverage.all.includes(:portions)
  end

  # Método para adicionar um item ao pedido
  def add_item
    quantity = params[:quantity].to_i
    portion_id = params[:portion_id]

    if quantity.positive? && portion_id.present?
      @order.order_items.create!(
        portion_id: portion_id,
        quantity: quantity
      )
      redirect_to select_items_order_path(@order), notice: "Item adicionado com sucesso!"
    else
      redirect_to select_items_order_path(@order), alert: "Selecione uma porção e quantidade válida."
    end
  end
  
  def create
    @order = Order.new(order_params)
    @menu = Menu.find_by(id: params[:order][:menu_id]) 

    if @order.save
      flash[:notice] = 'Pedido iniciado!'

      redirect_to select_items_order_path(@order)
    else
      @order.valid?
      flash.now[:alert] = 'Erro ao cadastrar pedido'

      render :new, status: :unprocessable_entity
    end
  end

def add_item

  @order = Order.find(params[:id])
  portion = Portion.find(params[:order_item][:portion_id])

   # Determina o nome do item dependendo do tipo (Dish ou Beverage)
   item_name = if portion.dish.present?
    portion.dish.name
  elsif portion.beverage.present?
    portion.beverage.name
  else
    'Item desconhecido'
  end

  @order_item = @order.order_items.build(
    portion_id: portion.id,
    quantity: params[:order_item][:quantity],
    observation: params[:order_item][:observation],
    item_name: item_name,
    unit_price: portion.price
  )
  if @order_item.save
    redirect_to order_path(@order), notice: "Item adicionado ao pedido."
  else
    redirect_to select_items_order_path(@order), alert: "Não foi possível adicionar o item. Verifique os dados e tente novamente."
  end
end

def select_portion
  @order = Order.find(params[:id])  # Carrega o pedido usando o ID passado na rota

  if params[:dish_id]
    @dish = Dish.find(params[:dish_id])
    @portions = @dish.portions
  elsif params[:beverage_id]
    @beverage = Beverage.find(params[:beverage_id])
    @portions = @beverage.portions
  end
  @order_item = OrderItem.new
end



  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def order_params
    params.require(:order).permit(
      :costumer_name, 
      :costumer_phone, 
      :costumer_email, 
      :costumer_doc, 
      :menu_id
      #order_items_attributes: [:dish_id, :drink_id, :portion_size, :note, :item_price]
    )
  end

  def order_item_params
    params.require(:order_item).permit(:portion_id, :quantity, :observation)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
