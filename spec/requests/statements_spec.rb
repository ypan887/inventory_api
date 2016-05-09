require 'rails_helper'

describe 'statements', type: :request do
  describe "index" do
    before :each do
      @product_1 = FactoryGirl.create(:product)
      product_2 = FactoryGirl.create(:product, name: Faker::Commerce.product_name, price: 20, cost: 10)
      @order1 = FactoryGirl.create(:order, :order_details_attributes => [{ :quantity => 1, :product_id => @product_1.id },{:quantity => 1, :product_id => product_2.id}])
      order2 = FactoryGirl.create(:order, order_date: "2016-04-06", :order_details_attributes => [{ :quantity => 1, :product_id => product_2.id }])
      @shipment1 = FactoryGirl.create(:shipment, ship_cost: 9, :shipment_details_attributes => [{ :quantity => 1, :product_id => @product_1.id },{ :quantity => 1, :product_id => product_2.id }])
      shipment2 = FactoryGirl.create(:shipment, ship_date: "2016-04-07", ship_cost: 5, :shipment_details_attributes => [{ :quantity => 1, :product_id => product_2.id }])
      @supply1 = FactoryGirl.create(:supply, :supply_details_attributes => [{ :quantity => 1, :product_id => @product_1.id },{ :quantity => 1, :product_id => product_2.id }])
      supply2 = FactoryGirl.create(:supply, order_date: "2016-04-08", :supply_details_attributes => [{ :quantity => 1, :product_id => product_2.id }])
      get "/statements"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return correct statement information' do
      body = json_response
      expect(body['data'].length).to eq(2)
      expect(body['data'].first['attributes']['income']).to eq(21.5)
      expect(body['data'].first['attributes']['shipping_cost']).to eq(9)
      expect(body['data'].first['attributes']['product_cost']).to eq(11.5)
      expect(body['data'].first['attributes']['profit']).to eq(1)
      expect(body['data'].first['attributes']['year_month']).to eq('2016-03')
      expect(body['data'].last['attributes']['income']).to eq(20)
      expect(body['data'].last['attributes']['shipping_cost']).to eq(5)
      expect(body['data'].last['attributes']['product_cost']).to eq(10)
      expect(body['data'].last['attributes']['profit']).to eq(5)
      expect(body['data'].last['attributes']['year_month']).to eq('2016-04')
    end

    it 'should update statments when supplies has changed' do
      patch "/supplies/#{@supply1.id}", { :supply_details_attributes => [{ :quantity => 2, :product_id => @product_1.id }] }, format: :json
      get "/statements"
      body = json_response
      expect(body['data'].first['attributes']['product_cost']).to eq(13)
    end

    it 'should update statments when shipment has changed' do
      patch "/shipments/#{@shipment1.id}", { ship_cost: 8}, format: :json
      get "/statements"
      body = json_response
      expect(body['data'].first['attributes']['shipping_cost']).to eq(8)
    end

    it 'should update statments when order has changed' do
      patch "/orders/#{@order1.id}", { :order_details_attributes => [{ :quantity => 2, :product_id => @product_1.id }] }, format: :json
      get "/statements"
      body = json_response
      expect(body['data'].first['attributes']['income']).to eq(23)
    end

    it 'should update statments when product price and cost has changed' do
      patch "/products/#{@product_1.id}", price: 3, cost: 0.5, format: :json
      get "/statements"
      body = json_response
      expect(body['data'].first['attributes']['profit']).to eq(3.5)
    end
  end
end