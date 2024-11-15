class OrderItemsController < ApplicationController
  def destroy
    order_item = OrderItem.find(params[:id])
    order = order_item.order

    if order_item.destroy
      redirect_to order_path(order), notice: 'Item removido com sucesso.'
    else
      redirect_to order_path(order), alert: 'Erro ao remover o item.'
    end
  end
end
