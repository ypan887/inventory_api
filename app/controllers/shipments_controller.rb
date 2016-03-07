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

  def index
    shipments = Shipment.all
    render json: shipments
  end

  def show
    shipment = Shipment.find(params[:id])
    render json: shipment
  end

private
  def shipment_params
    params.permit(:id, :tracking_number, :ship_date, :ship_cost, :shipment_details_attributes => [:quantity, :id, :shipment_id, :product_id, :deliver_check, :_destroy])
  end

end
