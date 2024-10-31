class DishesController < ApplicationController 
    before_action :authenticate_user!
    before_action :set_establishment
    before_action :set_dish, only: [:edit, :show, :update, :destroy]

    def index
      if params[:establishment_id]       
        @establishment = Establishment.find(params[:establishment_id])
        @dishes = @establishment.dishes
      elsif current_user.establishment
        @dishes = current_user.establishment.dishes
      else
        redirect_to root_path, alert: 'Você precisa cadastrar um restaurante para ver seus pratos.'
      end
    end

    def new
      @dish = Dish.new
    end

    def create
      
      @dish = Dish.new(dish_params)
      @dish.establishment = Establishment.find(params[:establishment_id])
      if @dish.save
        redirect_to establishment_dish_path(@dish.establishment, @dish), notice: 'Prato cadastrado com sucesso'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @dish = Dish.find(params[:id])
      if @dish.destroy
        redirect_to establishment_dishes_path(@dish.establishment), notice: 'Prato deletado com sucesso'
      else
        redirect_to establishment_dish_path(@dish.establishment, @dish), alert: 'Não foi possível deletar o prato.'
      end
    end
  

    def edit
      
    end

    def show
      
    end

    

    def update
      if @dish.update(dish_params)
        redirect_to establishment_dish_path(current_user.establishment, @dish), 
                         notice: 'Prato atualizado com sucesso'
      end
    end

    private

    def set_establishment
      @establishment = Establishment.find(params[:establishment_id])
    end

    def dish_params
      params.require(:dish).permit(:name, :description, :image, :calories)
    end

    def set_dish
      @dish = Dish.find(params[:id])
      unless @dish.establishment.user == current_user
        redirect_to root_path, alert: 'Acesso negado ao prato.'
      end
    end
end 