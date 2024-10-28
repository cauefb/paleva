class OpeningHoursController < ApplicationController
  before_action :set_establishment
  def new
    @opening_hour = @establishment.opening_hours.new
  end

  def create
    @opening_hour = @establishment.opening_hours.new(opening_hour_params)
    if @opening_hour.save
      redirect_to establishment_path(@establishment), notice: "Horário de funcionamento cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
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

  def opening_hour_params
    params.require(:opening_hour).permit(:day_of_week, :open_time, :close_time, :closed)
  end
end