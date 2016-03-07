require 'rails_helper'

describe 'shipments', type: :request do

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

  describe 'show' do
    let(:shipment) { FactoryGirl.create(:shipment)}

    before :each do
      get "/shipments/#{shipment.id}"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return the correct shipment' do
      body = json_response
      expect(body['data']['id'].to_i).to eq(shipment.id)
    end
  end

  describe 'create' do
    before :each do
      @product = FactoryGirl.create(:product)
    end

    it 'should create shipment for the customer with shipment date, ship cost and shipment detail' do
      post "/shipments", { ship_date: DateTime.now, ship_cost: 50, :shipment_details_attributes => [{ :quantity => 1, :product_id => @product.id }] }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["ship_date"]).to eq(DateTime.now.strftime("%Y-%m-%d"))
      expect(body['data']['attributes']["ship_cost"]).to eq(50)
      expect(body['data']['relationships']["shipment_details"]['data'][0]["quantity"]).to eq(1)
      expect(body['data']['relationships']["shipment_details"]['data'][0]["shipment_id"]).to eq(Shipment.last.id)
      expect(body['data']['relationships']["shipment_details"]['data'][0]["product_id"]).to eq(@product.id)
    end

    it 'should not create shipment without shipment date' do
      post "/shipments", { shipment_date: nil }, format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'update' do
    let(:shipment) { FactoryGirl.create(:shipment) }
    let(:product) { FactoryGirl.create(:product) }

    it "should update shipment with valid data" do
      patch "/shipments/#{shipment.id}", { ship_date: DateTime.now, ship_cost: 100, :shipment_details_attributes => [{ :quantity => 3, :product_id => product.id }] }, format: :json
      expect(response.status).to eq(200)
      shipment.reload
      body = json_response
      expect(body['data']['attributes']['ship_date']).to eq(DateTime.now.strftime("%Y-%m-%d"))
      expect(body['data']['attributes']["ship_cost"]).to eq(100)
      expect(body['data']['relationships']["shipment_details"]['data'][0]["quantity"]).to eq(3)
      expect(body['data']['relationships']["shipment_details"]['data'][0]["product_id"]).to eq(product.id)
    end

    it "should not update shipment with empty shipment_date" do
      patch "/shipments/#{shipment.id}", ship_date: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:shipment) { FactoryGirl.create(:shipment) }

    it "should delete the shipments" do
      expect{ delete "/shipments/#{shipment.id}"}.to change{Shipment.count}.by(-1)
    end
  end
end
