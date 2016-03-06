class ShipmentsController < ApplicationController

  def create
    shipment = Shipment.new(shipment_params)
    if shipment.save
      render json: shipment, status: 201
    else
      render json: { errors: shipment.errors }, status: 422
    end
  end

  def update
    shipment = Shipment.find(params[:id])

    if shipment.update(shipment_params)
      render json: shipment, status: 200
    else
      render json: { errors: shipment.errors }, status: 422
    end
  end

  def destroy
    shipment = Shipment.find(params[:id])
    shipment.destroy
    head 204
  end

private
  def shipment_params
    params.permit(:id, :tracking_number, :ship_date, :ship_cost)
  end

end
