class SearchController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_establishment
  
  def search
    query = "%#{params[:query].downcase}%"
    @dishes = @establishment.dishes.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", query, query)
    @beverages = @establishment.beverages.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", query, query)
  end

  def set_establishment
    @establishment = current_user.establishment
  end
end