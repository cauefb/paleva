class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_establishment
  before_action :set_menu, only: [:show, :remove_dish, :remove_beverage]
  def index
    @establishment = Establishment.find(params[:establishment_id])
    @menus = @establishment.menus
  end

  def show
    @establishment = Establishment.find(params[:establishment_id])
    @menu = @establishment.menus.find(params[:id])
  end

  def new
    @menu = @establishment.menus.build
  end

  def create
    Rails.logger.debug "Params recebidos: #{params.inspect}"
    @menu = @establishment.menus.build(menu_params)
    begin
      @menu.save!
      redirect_to  establishment_menu_path(@establishment, @menu), notice: "Cardápio criado com sucesso."
    rescue 
      flash[:alert] = "Essa cardápio já existe."
       flash.keep(:alert)  # Preserva a mensagem flash entre as requisições
      render :new, status: :unprocessable_entity
    end
    
    # @menu = @establishment.menus.build(menu_params)
    # if @menu.save
    #   redirect_to establishment_menu_path(@establishment, @menu), notice: "Cardápio criado com sucesso."
    # else
    #   flash[:alert] = @menu.errors.full_messages.to_sentence
    #   render :new
    # end
  end
  def remove_dish
    dish = Dish.find(params[:dish_id])
    if @menu.dishes.delete(dish)
      flash[:notice] = 'Prato removido do cardápio com sucesso.'
    else
      flash[:alert] = 'Não foi possível remover o prato do cardápio.'
    end
    redirect_to establishment_menu_path(@establishment, @menu)
  end

  def remove_beverage
    beverage = Beverage.find(params[:beverage_id])
    if @menu.beverages.delete(beverage)
      flash[:notice] = 'Bebida removida do cardápio com sucesso.'
    else
      flash[:alert] = 'Não foi possível remover a bebida do cardápio.'
    end
    redirect_to establishment_menu_path(@establishment, @menu)
  end
  private

  def set_establishment
    @establishment = current_user.establishment
  end

  def menu_params
    params.require(:menu).permit(:name, dish_ids: [], beverage_ids: [])
  end

  def set_menu
    @menu = @establishment.menus.find(params[:id])
  end
end
