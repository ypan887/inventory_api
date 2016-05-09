class CategoriesController < ApplicationController

  def index
    categoris = Category.all
    render json: categoris
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: 201
    else
      render json: { errors: category.errors.full_messages }, status: 422
    end
  end

  def update
    category = Category.find(params[:id])

    if category.update(category_params)
      render json: category, status: 200
    else
      render json: { errors: category.errors.full_messages }, status: 422
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    head 204
  end

private
  def category_params
    params.permit(:id, :name, :description)
  end
  
end

