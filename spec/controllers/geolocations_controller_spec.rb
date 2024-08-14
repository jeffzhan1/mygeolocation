require 'rails_helper'

RSpec.describe GeolocationsController, type: :controller do
  let(:geolocation) { Geolocation.create!(ip: ip) }
  let(:ip) { '135.201.250.155' }
  let(:ip2) { '122.133.111.22' }
  let(:ip3) { '432.345.22.654' }

  describe '#create' do
    subject(:add_geolocation_api) { post :create, params: { ip_address: ip_address }, format: :json }

    context "when ip address is invalid" do
      let(:ip_address) { ip3 }

      before do
        add_geolocation_api
      end

      it "return error message" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when ip address is valid" do
      let(:ip_address) { '122.133.111.22' }

      it "add the geolocation data in the database and return success" do
        expect { add_geolocation_api }.to change(Geolocation, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#show' do
    subject(:get_geolocation_api) { get :show, params: { ip_address: ip_address }, format: :json }

    context "when geolocation data does not exist" do
      let(:ip_address) { ip2 }

      before do
        get_geolocation_api
      end

      it "return error message" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the geolocation data exists" do
      let(:ip_address) { ip }

      before do
        geolocation
        get_geolocation_api
      end

      it "return the geolocation data" do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#destroy' do
    subject(:delete_geolocation_api) { get :destroy, params: { ip_address: ip_address }, format: :json }

    context "when geolocation data does not exist" do
      let(:ip_address) { ip2 }

      before do
        delete_geolocation_api
      end

      it "return error message" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the geolocation data exists" do
      let(:ip_address) { ip }

      before do
        geolocation
      end

      it "delete the geolocation data in the database and return success" do
        expect { delete_geolocation_api }.to change(Geolocation, :count).by(-1)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
