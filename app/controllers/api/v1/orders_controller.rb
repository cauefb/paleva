class Api::V1::OrdersController < ActionController::API
  before_action :find_establishment, only: [:index]

  def index
      # Verifica se o parâmetro de status é válido
      valid_statuses = Order.statuses.keys
      if params[:status].present? && valid_statuses.include?(params[:status])
        @orders = @establishment.orders.where(status: params[:status])
      else
        @orders = @establishment.orders
      end

      render json: @orders, status: :ok
  end

  private

  def find_establishment
    @establishment = Establishment.find_by!(code: params[:establishment_code])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Estabelecimento não encontrado' }, status: :not_found
  end
end