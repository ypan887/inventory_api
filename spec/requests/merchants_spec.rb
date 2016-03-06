require 'rails_helper'

describe 'merchants', type: :request do
  describe 'create' do
    it 'should create merchant with name' do
      post '/merchants', { name: "apple" }, format: :json
      expect(response.status).to eq(201)
      body = json_response
      expect(body['data']['attributes']["name"]).to eq("apple")
    end

    it 'should not create merchant without name' do
      post '/merchants', { }, format: :json
      expect(response.status).to eq(422)
      body = json_response
      expect(body['errors']).to eq("name" => ["can't be blank"])
    end
  end

  describe 'update' do
    let(:merchant) { FactoryGirl.create(:merchant) }

    it "should update merchant with valid data" do
      patch "/merchants/#{merchant.id}", name: "google", format: :json
      expect(response.status).to eq(200)
      merchant.reload
      body = json_response
      expect(body['data']['attributes']['name']).to eq("google")
    end

    it "should not update merchant with empty name" do
      patch "/merchants/#{merchant.id}", name: "", format: :json
      expect(response.status).to eq(422)
    end
  end

  describe 'destroy' do
    let!(:merchant) { FactoryGirl.create(:merchant) }

    it "should delete the merchants" do
      expect{ delete "/merchants/#{merchant.id}"}.to change{Merchant.count}.by(-1)
    end
  end
end