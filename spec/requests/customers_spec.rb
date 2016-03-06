require 'rails_helper'

describe 'customers', type: :request do

  describe "index" do
    before :each do
      customers = FactoryGirl.create_list(:customer, 2)
      get "/customers"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return an array of customers' do
      body = json_response
      expect(body['data'].length).to eq(2)
    end
  end

  describe 'show' do
    let(:customer) { FactoryGirl.create(:customer)}

    before :each do
      get "/customers/#{customer.id}"
    end

    it 'should have an endpoint' do
      expect(response).to be_success
    end

    it 'should return the correct customer' do
      body = json_response
      expect(body['data']['id'].to_i).to eq(customer.id)
    end
  end

  describe 'create' do
    it 'should create customer with name' do
      post '/customers', { name: "test" }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["name"]).to eq("test")
    end

    it 'should not create customer without name' do
      post '/customers', { country: "USA"}, format: :json
      expect(response.status).to eq(422)
      body = json_response
      expect(body['errors']).to eq("name" => ["can't be blank"])
    end
  end

  describe 'update' do
    let(:customer) { FactoryGirl.create(:customer) }

    it "should update customer with valid data" do
      patch "/customers/#{customer.id}", name: "test1", format: :json
      expect(response.status).to eq(200)
      customer.reload
      body = json_response
      expect(body['data']['attributes']['name']).to eq("test1")
    end

    it "should not update customer with empty name" do
      patch "/customers/#{customer.id}", name: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:customer) { FactoryGirl.create(:customer) }

    it "should delete the customers" do
      expect{ delete "/customers/#{customer.id}"}.to change{Customer.count}.by(-1)
    end
  end
end
