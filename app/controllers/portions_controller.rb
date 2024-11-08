class PortionsController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_portion, only: [:edit, :update]
  before_action :set_dish_or_beverage
  
  def new
    @portion = Portion.new
  end

  def create
    # Criação de uma nova porção
    @portion = @parent.portions.build(portion_params)
    if @portion.save
      redirect_to [@parent, @portion], notice: 'Porção criada com sucesso.'
    else
      flash.now[:alert] = @portion.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @portion.update(portion_params)
      if @portion.previous_changes.key?("price")
        PortionPriceHistory.create!(
          portion: @portion,
          price: @portion.price_before_last_save,
          date: Time.current.in_time_zone
        )
      end
      if @parent.is_a?(Dish)
        redirect_to establishment_dish_path(current_user.establishment, @parent), notice: 'Porção editada com sucesso.'
      elsif @parent.is_a?(Beverage)
        redirect_to establishment_beverage_path(current_user.establishment, @parent), notice: 'Porção editada com sucesso.'
      end
    else
      flash.now[:alert] = 'Não foi possível atualizar a Porção'
      render :edit, status: :unprocessable_entity
    end
  end
  
  private

  def set_portion
    @portion = Portion.find(params[:id])
  end

  def set_dish_or_beverage
    if params[:dish_id]
      @parent = Dish.find(params[:dish_id])
    elsif params[:beverage_id]
      @parent = Beverage.find(params[:beverage_id])
    else
      redirect_to root_path, alert: 'Prato ou bebida não especificado.'
    end
  end

  def portion_params
    params.require(:portion).permit(:description, :price).tap do |portion_params|
      if portion_params[:price].present?
        # Substitui vírgula por ponto, converte para float, e multiplica por 100 para salvar como centavos
        portion_params[:price] = (portion_params[:price].tr(',', '.').to_f * 100).to_i
      end
    end
  end
end