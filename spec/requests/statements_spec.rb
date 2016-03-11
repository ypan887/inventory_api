require 'rails_helper'

describe 'statements', type: :request do

  describe "index" do
    before :each do
      shipments = FactoryGirl.create_list(:shipment, 2)
      get "/shipments"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return an array of shipments' do
      body = json_response
      expect(body['data'].length).to eq(2)
    end
  end
  
end