require 'socket'
require "ipaddress"

class GeolocationsController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index
  end

  def create
    ip_address = params["ip_address"]
    if ip_address.nil?
	    ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
	    ip_address = ip.ip_address
	  end

    if ip_address.nil?
      render422_json(
        json_ext: {
          error_message: "ip address is empty."
        }
      )
      return
    end

    if !IPAddress.valid?(ip_address)
      render422_json(
        json_ext: {
          error_message: "The ip address is invalid."
        }
      )
      return
    end

    service_provider_name = SERVER_CONFIG["geo_service_providers"]["default"]

    service_provider_config = SERVER_CONFIG["geo_service_providers"][service_provider_name]
    service_provider = GeolocationServiceProvider.create(service_provider_config)

    begin
    	geolocation_params = service_provider.lookup_geolocation(ip_address)
    rescue => e
      render422_json(
        json_ext: {
          error_message: e.message
        }
      )
      return
    end

    if geolocation_params.blank?
      render422_json(
        json_ext: {
          error_message: "Cannot find the geolocation data!"
        }
      )
      return
    end

    @geolocation = Geolocation.find_by(ip: ip_address)

    if @geolocation.blank?
    	@geolocation = Geolocation.new(geolocation_params)
    else
    	@geolocation.assign_attributes(geolocation_params)
    end

    if @geolocation.save
      render :show
    else
      render422_json(
        json_ext: {
          error_message: @geolocation.errors.full_messages.join("; ")
        }
      )
    end

  end

  def show
    ip_address = params["ip_address"]
    if !IPAddress.valid?(ip_address)
      render422_json(
        json_ext: {
          error_message: "The ip address is invalid."
        }
      )
      return
    end
    
    @geolocation = Geolocation.find_by(ip: ip_address)

    if @geolocation.blank?
      render422_json(
        json_ext: {
          error_message: "Cannot find the geolocation data!"
        }
      )
      return
    end
  end

  def destroy
    ip_address = params["ip_address"]
    if !IPAddress.valid?(ip_address)
      render422_json(
        json_ext: {
          error_message: "The ip address is invalid."
        }
      )
      return
    end

    @geolocation = Geolocation.find_by(ip: ip_address)

    if @geolocation.blank?
      render422_json(
        json_ext: {
          error_message: "The geolocation does not exist."
        }
      )
      return
    end

    if @geolocation.destroy
      render :show
    else
      render422_json(
        json_ext: {
          error_message: @geolocation.errors.full_messages.join("; ")
        }
      )
    end
  end

end
