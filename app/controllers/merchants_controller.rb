class MerchantsController < ApplicationController

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      render json: merchant, status: 201
    else
      render json: { errors: merchant.errors.full_messages }, status: 422
    end
  end

  def update
    merchant = Merchant.find(params[:id])

    if merchant.update(merchant_params)
      render json: merchant, status: 200
    else
      render json: { errors: merchant.errors.full_messages }, status: 422
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    merchant.destroy
    head 204
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: merchant
  end

  def index
    merchants = Merchant.all
    render json: merchants
  end

private
  def merchant_params
    params.permit(:id, :name)
  end
end
