require 'rails_helper'

describe 'supplies', type: :request do

  describe "index" do
    before :each do
      merchant = FactoryGirl.create(:merchant)
      supplies = FactoryGirl.create_list(:supply, 2, :merchant => merchant)
      get "/merchants/#{merchant.id}/supplies"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return an array of supplies' do
      body = json_response
      expect(body['data'].length).to eq(2)
    end
  end

  describe 'show' do
    let(:supply) { FactoryGirl.create(:supply)}

    before :each do
      get "/supplies/#{supply.id}"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return the correct supply' do
      body = json_response
      expect(body['data']['id'].to_i).to eq(supply.id)
    end
  end

  describe 'create' do
    before :each do
      @merchant = FactoryGirl.create(:merchant)
      @product = FactoryGirl.create(:product)
    end

    it 'should create supply for the customer with supply date, ship cost and supply detail' do
      post "/merchants/#{@merchant.id}/supplies", { order_date: DateTime.now, :supply_details_attributes => [{ :quantity => 1, :product_id => @product.id }] }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["order_date"]).to eq(DateTime.now.strftime("%Y-%m-%d"))
      expect(body['data']['relationships']["supply_details"]['data'][0]["quantity"]).to eq(1)
      expect(body['data']['relationships']["supply_details"]['data'][0]["supply_id"]).to eq(Supply.last.id)
      expect(body['data']['relationships']["supply_details"]['data'][0]["product_id"]).to eq(@product.id)
    end

    it 'should not create supply without supply date' do
      post "/merchants/#{@merchant.id}/supplies", { order_date: nil }, format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'update' do
    let(:supply) { FactoryGirl.create(:supply) }
    let(:product) { FactoryGirl.create(:product) }

    it "should update supply with valid data" do
      patch "/supplies/#{supply.id}", { order_date: DateTime.now + 1, :supply_details_attributes => [{ :quantity => 3, :product_id => product.id }] }, format: :json
      expect(response.status).to eq(200)
      supply.reload
      body = json_response
      expect(body['data']['attributes']['order_date']).to eq((DateTime.now + 1).strftime("%Y-%m-%d"))
      expect(body['data']['relationships']["supply_details"]['data'][0]["quantity"]).to eq(3)
      expect(body['data']['relationships']["supply_details"]['data'][0]["product_id"]).to eq(product.id)
    end

    it "should not update supply with empty supply_date" do
      patch "/supplies/#{supply.id}", order_date: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:supply) { FactoryGirl.create(:supply) }

    it "should delete the supplies" do
      expect{ delete "/supplies/#{supply.id}"}.to change{Supply.count}.by(-1)
    end
  end
end
