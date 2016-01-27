class CatRentalRequestsController < ApplicationController

  def new
    render :new
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by_id(params[:id])
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def index
    @cat_rental_requests = CatRentalRequest.all
    render :index
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.save!
    redirect_to cat_rental_request_url(@cat_rental_request.id)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
