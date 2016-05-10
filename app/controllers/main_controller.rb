class MainController < ApplicationController
  def index
    render json: {
      data: [{
        type: "responses",
        attributes: {
          ping: true, 
          message: "Welcome to the Inventory Controller Api, please visist resources endpoint for data"
        }
      }]
    }
  end
end
