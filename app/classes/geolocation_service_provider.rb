require 'net/http'
require 'net/https'

class GeolocationServiceProvider

  def self.create(config)
    new(config).extend(const_get(config['adapter']))
  end

  def initialize(config)
    @config = config
  end

  def lookup_geolocation(ip_address)
    # use Net::HTTP to communicate with geolocation service
    url = URI.parse(lookup_url(@config, ip_address))

    # establish connection
    http = Net::HTTP.new(url.host, url.port)

    # provide for HTTPS
    if url.scheme == "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    # form HTTP request
    req = Net::HTTP::Get.new(url.request_uri)

    # send GET request
    res = http.request(req)

    # analyse response
    case res
      when Net::HTTPSuccess
        result = adapt(ip_address, res.body)
      when Net::HTTPNotFound
        result = {}
      else
        raise res.value
    end

    result
  end

end
