class OpeningHoursController < ApplicationController
  before_action :set_establishment
  def new
    @opening_hour = @establishment.opening_hours.new
  end

  # def create
  #   @opening_hour = @establishment.opening_hours.new(opening_hour_params)
  #   if @opening_hour.save
  #     redirect_to establishment_path(@establishment), notice: "Horário de funcionamento cadastrado com sucesso."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end
  # EstabelecimentoController.rb
def create
  Rails.logger.debug("Parâmetros recebidos no create: #{params.inspect}")
  byebug 
  saved_hours = []

  opening_hours_params.each do |day_params|
    opening_hour = @establishment.opening_hours.find_or_initialize_by(day_of_week: day_params[:day_of_week])
    opening_hour.assign_attributes(day_params)

    if opening_hour.save
      saved_hours << opening_hour
    else
      flash.now[:alert] = "Erro ao salvar o horário para #{day_params[:day_of_week].capitalize}."
      return render :new, status: :unprocessable_entity
    end
  end

  redirect_to establishment_path(@establishment), notice: "Horários de funcionamento cadastrados com sucesso."
end

private

def opening_hours_params
  params.require(:establishment).permit(opening_hours_attributes: [:day_of_week, :open_time, :close_time, :closed])[:opening_hours_attributes].values
end

  # def edit
    
  # end
  # def show
    
  # end
  # 
  private

  private

  def set_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def opening_hours_params
    # Permite parâmetros para múltiplos dias de funcionamento
    params.require(:establishment).permit(opening_hours_attributes: [:day_of_week, :open_time, :close_time, :closed])[:opening_hours_attributes].values
  end
end