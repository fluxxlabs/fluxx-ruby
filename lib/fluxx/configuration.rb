module Fluxx
  module Configuration

    OPTIONS = [
      :protocol, :server_url, :oauth_client_id, :oauth_client_secret
    ].freeze

    def self.included(base)
      base.extend ClassMethods
      base.reset_config
    end

    module ClassMethods

      attr_accessor *OPTIONS
      attr_reader :oauth_access_token

      def configure
        yield self if block_given?
        get_access_token if protocol.eql?(:http)
        true
      end

      def reset_config
        @protocol            = :http
      end

      def get_access_token
        response = RestClient.post "#{@server_url}/oauth/token", {
          grant_type:    'client_credentials',
          client_id:     @oauth_client_id,
          client_secret: @oauth_client_secret
        }
        @oauth_access_token = JSON.parse(response)['access_token']
        true
      end

    end

  end
end