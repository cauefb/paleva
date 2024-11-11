class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_establishment

  def index
     @establishment = current_user.establishment
  @menus = @establishment&.menus || []
  end

  private
  def set_establishment
    @establishment = current_user.establishment
  end
end