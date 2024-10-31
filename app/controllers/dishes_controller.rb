class DishesController < ApplicationController 
    
    before_action :set_dish, only: [:edit, :show, :update]

    def index
      if params[:establishment_id]
        # Quando a rota está no contexto de um estabelecimento específico
        @establishment = Establishment.find(params[:establishment_id])
        @dishes = @establishment.dishes
      elsif current_user.establishment
        # Quando a rota é chamada sem um `establishment_id`, exibe os pratos do restaurante do usuário logado
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

    def edit
      
    end

    def show
      
    end

    def update
      puts("caiu aqui")
      if @dish.update(dish_params)
        redirect_to establishment_dish_path(current_user.establishment, @dish), 
                         notice: 'Prato atualizado com sucesso'
      end
    end

    def dish_params
      params.require(:dish).permit(:name, :description, :image, :calories)
    end

    def set_dish
      @dish = Dish.find(params[:id])
    end
end 