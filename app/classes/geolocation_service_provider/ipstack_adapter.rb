class GeolocationServiceProvider
  module IpstackAdapter
    def lookup_url(config, ip_address)
      # format URL string with the ip_address to look up
      format(config['api_url'], ip_address, config['api_access_key'])
    end

    def adapt(ip_address, input)
      result = JSON.parse(input)

      geolocation_params = get_geolocation_params(result)

      if geolocation_params[:ip] != ip_address
      	return {}
      end

      geolocation_params
    end

    def get_geolocation_params(result)
  	  {
        ip: result["ip"],
        ip_type: result["type"],
        continent_code: result["continent_code"],
        continent_name: result["continent_name"],
        country_code: result["country_code"],
        country_name: result["country_name"],
        region_code: result["region_code"],
        region_name: result["region_name"],
        city: result["city"],
        zip: result["zip"],
        latitude: result["latitude"],
        longitude: result["longitude"],
        msa: result["msa"],
        dma: result["dma"],
        radius: result["radius"]
  	  }
    end    
  end
end

