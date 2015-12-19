require 'rest-client'

module Fluxx
  SERVER = 'fluxx.io'

  class << self
    attr_accessor :client_id, :client_secret, :client_name, :verify_ssl_certs, :api_version
  end

  def self.request
    response = RestClient.post "#{@client_name}.#{SERVER}/oauth/token", {
      grant_type: 'client_credentials',
      client_id: @client_id,
      client_secret: @client_secret
    }
    @token = JSON.parse(response)['access_token']
  end

  def self.user
    data = RestClient.get "/api/rest/v1/user", { "Authorization" => "Bearer #{@token}" }
    JSON.parse(data)['records']['user'].first
  end
end
