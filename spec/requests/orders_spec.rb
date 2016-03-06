require 'rails_helper'

describe 'orders', type: :request do

  describe "index" do
    before :each do
      customer = FactoryGirl.create(:customer)
      orders = FactoryGirl.create_list(:order, 2, :customer => customer)
      get "/customers/#{customer.id}/orders"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return an array of orders' do
      body = json_response
      expect(body['data'].length).to eq(2)
    end
  end

  describe 'show' do
    let(:order) { FactoryGirl.create(:order)}

    before :each do
      get "/orders/#{order.id}"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return the correct order' do
      body = json_response
      expect(body['data']['id'].to_i).to eq(order.id)
    end
  end

  describe 'create' do
    before :each do
      @customer = FactoryGirl.create(:customer)
    end

    it 'should create order for the customer with order date' do
      post "/customers/#{@customer.id}/orders", { order_date: DateTime.now }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["order_date"]).to eq(DateTime.now.strftime("%Y-%m-%d"))
    end

    it 'should not create order without order date' do
      post "/customers/#{@customer.id}/orders", { order_date: nil }, format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'update' do
    let(:order) { FactoryGirl.create(:order) }

    it "should update order with valid data" do
      patch "/orders/#{order.id}", order_date: DateTime.now, format: :json
      expect(response.status).to eq(200)
      order.reload
      body = json_response
      expect(body['data']['attributes']['order_date']).to eq(DateTime.now.strftime("%Y-%m-%d"))
    end

    it "should not update order with empty order_date" do
      patch "/orders/#{order.id}", order_date: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:order) { FactoryGirl.create(:order) }

    it "should delete the orders" do
      expect{ delete "/orders/#{order.id}"}.to change{Order.count}.by(-1)
    end
  end
end
