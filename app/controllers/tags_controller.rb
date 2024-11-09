# app/controllers/tags_controller.rb
class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tags = Tag.all
  end

  def new
    @tags = Tag.all
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    begin
      @tag.save!
      redirect_to new_tag_path, notice: 'Tag criada com sucesso.'
    rescue ActiveRecord::RecordNotUnique
       flash[:alert] = "Essa tag já existe."
       flash.keep(:alert)  # Preserva a mensagem flash entre as requisições
      redirect_to new_tag_path
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
