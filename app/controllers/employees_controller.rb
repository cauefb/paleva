class EmployeesController < ApplicationController
  before_action :authenticate_user!
  #before_action :authorize_owner!

  def index
    @employee = current_user.establishment.employees
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = current_user.establishment.employees.new(pre_registered_user_params)
    if @employee.save
      redirect_to employees_path, notice: "Usuário pré-cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pre_registered_user_params
    params.require(:employee).permit(:email, :cpf)
  end

  def authorize_owner!
    redirect_to root_path, alert: "Acesso não autorizado." unless current_user.restaurant_owner?
  end
end
