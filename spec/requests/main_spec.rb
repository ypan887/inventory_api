require 'rails_helper'

describe 'main', type: :request do
  describe "index" do
    it 'should have index endpoint and display welcome message' do
      get("/")
      response = JSON.parse(body)["data"][0]["attributes"]
      expect(response['ping']).to be true
      expect(response['message']).to eq("Welcome to the Inventory Controller Api, please visist resources endpoint for data")
    end
  end
end