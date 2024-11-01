class BeveragesController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_establishment
  #before_action :set_beverage, only: [:edit, :show, :update, :destroy]

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
    @beverage = Beverage.find(params[:id])
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