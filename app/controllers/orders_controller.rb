class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_establishment

  def show
    @order = Order.find(params[:id])
  end
  def new
    @establishment = current_user.establishment
    @menu = @establishment.menus.find(params[:menu_id]) # Certifique-se de passar o menu_id na URL
    @order = @menu.orders.build
  end
  

  def create
    @order = Order.new(order_params)

    if @order.save
      flash[:notice] = 'Pedido cadastrado com sucesso!'

      redirect_to @order
    else
      @order.valid?
      flash.now[:alert] = 'Erro ao cadastrar pedido'

      render :new, status: :unprocessable_entity
    end
  end

  # def finalize
  #   @order = @establishment.orders.find(params[:id])
  #   @order.update(status: :waiting_confirmation)
  #   redirect_to orders_path, notice: "Pedido enviado para a cozinha!"
  # end

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
end
