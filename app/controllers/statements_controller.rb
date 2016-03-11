class StatementsController < ApplicationController
  def index
    statements = Statement.all
    render json: statements
  end
end
