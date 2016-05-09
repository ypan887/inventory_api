require 'rails_helper'

describe 'categories', type: :request do

  describe "index" do
    before :each do
      category = FactoryGirl.create(:category)
      category_2 = FactoryGirl.create(:category, :name => "another category")
      products = FactoryGirl.create_list(:product, 3, :category => category)
      get "/categories"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return an array of products' do
      body = json_response
      expect(body['data'].length).to eq(2)
      expect(body['data'][0]['attributes']['products'].length).to eq(3)
    end
  end

  describe 'create' do
    it 'should create category with name' do
      post '/categories', { name: "electronic", description: "regular electronic items" }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["name"]).to eq("Electronic")
      expect(body['data']['attributes']["description"]).to eq("regular electronic items")
    end

    it 'should not create category without name' do
      post '/categories', { }, format: :json
      expect(response.status).to eq(422)
      body = json_response
      expect(body['errors']).to eq(["Name can't be blank"])
    end
  end

  describe 'update' do
    let(:category) { FactoryGirl.create(:category) }

    it "should update category with valid data" do
      patch "/categories/#{category.id}", name: "shoes", format: :json
      expect(response.status).to eq(200)
      category.reload
      body = json_response
      expect(body['data']['attributes']['name']).to eq("Shoes")
    end

    it "should not update category with empty name" do
      patch "/categories/#{category.id}", name: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:category) { FactoryGirl.create(:category) }

    it "should delete the categories" do
      expect{ delete "/categories/#{category.id}"}.to change{Category.count}.by(-1)
    end
  end
end