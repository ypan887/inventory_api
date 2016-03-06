class SuppliesController < ApplicationController

  def create
    supply = Supply.new(supply_params)
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

private
  def supply_params
    params.permit(:id, :order_date)
  end

end
