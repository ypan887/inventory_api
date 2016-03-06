class OrdersController < ApplicationController
  before_action :current_customer, only: [:create, :index]
  
  def create
    order = @customer.orders.build(order_params)
    if order.save
      render json: order, status: 201
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  def update
    order = Order.find(params[:id])

    if order.update(order_params)
      render json: order, status: 200
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    head 204
  end

  def show
    order = Order.find(params[:id])
    render json: order
  end

  def index
    orders = @customer.orders.all
    render json: orders
  end

private
  def order_params
    params.permit(:id, :customer_id, :order_date)
  end

  def current_customer
    @customer = Customer.find(params[:customer_id])
  end

end
