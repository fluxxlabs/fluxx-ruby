require 'json'
require 'rest-client'
require 'drb'

require 'fluxx/protocol'
require 'fluxx/fluxx_object'
require 'fluxx/api_resource'
require 'fluxx/user'
require 'fluxx/grant_request'
require 'fluxx/form'

module Fluxx
  SERVER = 'fluxx.io'

  class << self
    attr_accessor :client_id, :client_secret, :client_name, :verify_ssl_certs, :api_version
    attr_reader :token
  end

  def self.request
    # response = RestClient.post "#{server_url}/oauth/token", {
    #   grant_type: 'client_credentials',
    #   client_id: @client_id,
    #   client_secret: @client_secret
    # }
    # @token = JSON.parse(response)['access_token']
  end

  def self.server_url
    "#{@client_name}.#{SERVER}"
  end
end
