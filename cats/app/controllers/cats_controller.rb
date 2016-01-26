class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.save!
    redirect_to cat_url(@cat.id)
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end
end