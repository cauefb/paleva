class EstablishmentsController < ApplicationController

  before_action :set_establishment, only: [:edit, :update]

  def index
    
  end
  def new
    @establishment = Establishment.new
    days_in_portuguese = I18n.t('date.day_names').map(&:capitalize) + ["Feriado"] 
  
    days_in_portuguese.each do |day|
      @establishment.opening_hours.build(day_of_week: day) 
    end
  end

  def create
    @establishment = Establishment.new(establishment_params)
    @establishment.user = current_user
    if @establishment.save
      
      redirect_to @establishment, notice: 'Estabelecimento criado com sucesso.'
    else
      flash[:notice] = 'Não foi possível atualizar o estabelecimento'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @establishment = Establishment.find(params[:id])
    @opening_hours = @establishment.opening_hours
  end
  def edit;  end
  
  def update
    
    if @establishment.update(establishment_params)
      redirect_to root_path, notice: 'Estabelecimento atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar o estabelecimento'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def establishment_params
    params.require(:establishment).permit(:brand_name, :corporate_name, :cnpj, :address, :phone, :email, :code, :user_id,
                                          opening_hours_attributes: [:id,:day_of_week, :open_time, :close_time, :closed])
  end

  def set_establishment
    @establishment = Establishment.find(params[:id])
  end
end