class EstablishmentsController < ApplicationController

  #before_action :set_establishment, only: [:show, :edit, :update, :destroy]

  def index
    
  end
  def new
    @establishment = Establishment.new
  end

  def create
    @establishment = Establishment.new(establishment_params)
    @establishment.user = current_user
    if @establishment.save!
      
      redirect_to @establishment, notice: 'Estabelecimento criado com sucesso.'
    else
      render :index
    end
  end

  def show
    @establishment = Establishment.find(params[:id])
    @opening_hours = @establishment.opening_hours
  end

  private

  def establishment_params
    params.require(:establishment).permit(:brand_name, :corporate_name, :cnpj, :address, :phone, :email, :code, :user_id)
  end

  def set_establishment
    @establishment = Establishment.find(params[:id])
  end
end