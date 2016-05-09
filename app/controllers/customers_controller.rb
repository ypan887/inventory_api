class CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: customer, status: 201
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def update
    customer = Customer.find(params[:id])

    if customer.update(customer_params)
      render json: customer, status: 200
    else
      render json: { errors: customer.errors.full_messages }, status: 422
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    head 204
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer
  end

  def index
    customers = Customer.all
    render json: customers
  end

private
  def customer_params
    params.permit(:id, :name, :address, :zip_code, :country, :photo_id)
  end
end
