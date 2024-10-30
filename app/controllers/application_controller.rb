class ApplicationController < ActionController::Base
  # Permite navegadores modernos
  allow_browser versions: :modern

  # Before actions
  #before_action :redirect_to_login
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_restaurant_presence, if: -> { request.path == root_path }

  protected

  # Configuração de parâmetros permitidos para Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :last_name, :cpf])
  end

  # Redireciona para a tela de login se o usuário não estiver logado
  def redirect_to_login
    if !user_signed_in? && request.path == root_path
      redirect_to new_user_session_path
    end
  end

  # Verifica se o usuário logado possui um estabelecimento
  def check_restaurant_presence
    if user_signed_in? && current_user.establishment.nil?
      redirect_to new_establishment_path, alert: 'Você precisa cadastrar um restaurante antes de continuar.'
    end
  end
end
