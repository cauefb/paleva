class BeveragesController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_establishment
  before_action :set_beverage, only: [:edit, :show, :update, :enabled, :disabled]

  def index
    if params[:establishment_id]       
      @establishment = Establishment.find(params[:establishment_id])
      @beverages = @establishment.beverages
    elsif current_user.establishment
      @beverages = current_user.establishment.beverages
    else
      redirect_to root_path, alert: 'Você precisa cadastrar um restaurante para ver seus pratos.'
    end
  end

  def new
    @beverage = Beverage.new
  end

  def create
    @beverage = Beverage.new(beverage_params)
    @beverage.establishment = Establishment.find(params[:establishment_id])
    if @beverage.save
      redirect_to establishment_beverage_path(@beverage.establishment, @beverage), notice: 'Bebida cadastrada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @portions = @beverage.portions
  end

  def edit
      
  end

  def update
    if @beverage.update(beverage_params)
      redirect_to establishment_beverage_path(current_user.establishment, @beverage), 
                       notice: 'Bebida atualizada com sucesso'
    end
  end

  def disabled
    @beverage.update(active: false)
    redirect_to establishment_beverage_path(@beverage.establishment, @beverage)
  end
  
  def enabled
    @beverage.update(active: true)
    redirect_to establishment_beverage_path(@beverage.establishment, @beverage)
  end

  def destroy
    @beverage = Beverage.find(params[:id])
    if @beverage.destroy
      redirect_to establishment_beverages_path(@beverage.establishment), notice: 'Bebida deletada com sucesso'
    else
      redirect_to establishment_beverages_path(@beverage.establishment, @beverage), alert: 'Não foi possível deletar a bebida.'
    end
  end
  private

  def set_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def beverage_params
    params.require(:beverage).permit(:name, :description, :image, :calories, :is_alcholic)
  end

  def set_beverage
    @beverage = Beverage.find(params[:id])
    unless @beverage.establishment.user == current_user
      redirect_to root_path, alert: 'Acesso negado a bebida.'
    end
  end
end 