class SuppliesController < ApplicationController
  before_action :current_merchant, only: [:create, :index]

  def create
    supply = @merchant.supplies.build(supply_params)
    if supply.save
      render json: supply, status: 201
    else
      render json: { errors: supply.errors }, status: 422
    end
  end

  def update
    supply = Supply.find(params[:id])

    if supply.update(supply_params)
      render json: supply, status: 200
    else
      render json: { errors: supply.errors }, status: 422
    end
  end

  def destroy
    supply = Supply.find(params[:id])
    supply.destroy
    head 204
  end

  def index
    supplies = Supply.all
    render json: supplies
  end

  def show
    supply = Supply.find(params[:id])
    render json: supply
  end

private
  def supply_params
    params.permit(:id, :order_date, :merchant_id, :supply_details_attributes => [:quantity, :id, :supply_id, :product_id, :deliver_check, :_destroy])
  end

  def current_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

end
