require 'rails_helper'

describe 'products', type: :request do

  describe "index" do
    before :each do
      category = FactoryGirl.create(:category)
      products = FactoryGirl.create_list(:product, 2, :category => category)
      get "/categories/#{category.id}/products"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return an array of products' do
      body = json_response
      expect(body['data'].length).to eq(2)
    end
  end

  describe 'show' do
    let(:product) { FactoryGirl.create(:product)}

    before :each do
      get "/products/#{product.id}"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return the correct product' do
      body = json_response
      expect(body['data']['id'].to_i).to eq(product.id)
    end
  end

  describe 'create' do
    before :each do
      @category = FactoryGirl.create(:category)
    end

    it 'should create product for the category with correct information' do
      post "/categories/#{@category.id}/products", { name:"nike air", price: 120, cost: 99.9 }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["name"]).to eq("nike air")
      expect(body['data']['attributes']["price"]).to eq(120)
      expect(body['data']['attributes']["cost"]).to eq(99.9)
      expect(body['data']['attributes']["category"]["id"]).to eq(@category.id)
    end

    it 'should not create product without product date' do
      post "/categories/#{@category.id}/products", { price: 120, cost: 99.9 }, format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'update' do
    let(:product) { FactoryGirl.create(:product) }

    it "should update product with valid data" do
      patch "/products/#{product.id}", name: "Irobot 880", format: :json
      expect(response.status).to eq(200)
      product.reload
      body = json_response
      expect(body['data']['attributes']['name']).to eq("Irobot 880")
    end

    it "should not update product with empty name" do
      patch "/products/#{product.id}", name: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:product) { FactoryGirl.create(:product) }

    it "should delete the products" do
      expect{ delete "/products/#{product.id}"}.to change{Product.count}.by(-1)
    end
  end
end
