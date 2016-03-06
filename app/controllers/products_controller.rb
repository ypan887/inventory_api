class ProductsController < ApplicationController
  before_action :current_category, only: [:create, :index]
  
  def create
    product = @category.products.build(product_params)
    if product.save
      render json: product, status: 201
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json: product, status: 200
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    head 204
  end

  def show
    product = Product.find(params[:id])
    render json: product
  end

  def index
    products = @category.products.all
    render json: products
  end

private
  def product_params
    params.permit(:id, :category_id, :name, :price, :cost)
  end

  def current_category
    @category = Category.find(params[:category_id])
  end

end
