class Api::V1::OrdersController < ActionController::API
  before_action :find_establishment
  before_action :find_order, only: [:show, :accept]

  def index
      valid_statuses = Order.statuses.keys
      if params[:status].present? && valid_statuses.include?(params[:status])
        @orders = @establishment.orders.where(status: params[:status])
      else
        @orders = @establishment.orders
      end

      render json: @orders, status: :ok
  end

  def show
    render json: {
      costumer_name: @order.costumer_name,
      code: @order.code,
      items: @order.order_items.map do |item|
        {
          name: item.item_name,
          quantity: item.quantity,
          unit_price: item.unit_price,
          observation: item.observation
        }
      end,
      created_at: @order.created_at,
      status: @order.status
    }, status: :ok
  end

  def accept
    if @order.pending_kitchen?
      @order.preparing!
      render json: { message: 'Pedido aceito e agora está em preparação', status: @order.status }, status: :ok
    else
      render json: { error: 'Somente pedidos pendentes podem ser aceitos' }, status: :unprocessable_entity
    end
  end

  private

  def find_establishment
    @establishment = Establishment.find_by!(code: params[:establishment_code])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Estabelecimento não encontrado' }, status: :not_found
  end

  def find_order
    @order = @establishment.orders.find_by!(code: params[:order_code])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pedido não encontrado' }, status: :not_found
  end
end