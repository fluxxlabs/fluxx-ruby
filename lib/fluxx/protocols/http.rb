module Fluxx
  module Protocols
    class Http

      ACTIONS = {
        list: {},
        fetch: {
          requires_id: true
        },
        create: {
          http_method: :post
        },
        update: {
          requires_id: true,
          http_method: :put
        },
        destroy: {
          requires_id: true,
          http_method: :delete
        }
      }.freeze

      def initialize(params)        
        @model_type  = params[:model_type]
        @model_id    = params[:model_id]
        @options     = params[:options]
        @action      = params[:action]
        @data        = params[:data]
      end

      def call
        RestClient.send http_method, url, call_params
      end

      protected

      def http_method
        action_info[:http_method] || :get
      end

      def action_info
        ACTIONS[@action] || raise(FluxxError, "not a valid action")
      end

      def call_params
        auth_header.tap do |params|
          params[:params] = @options if @options
          params[:data]   = @data if @data
        end
      end

      def path
        action_info[:requires_id] ? "/#{@model_id}" : ""
      end

      def url
        url_base + path
      end

      def url_base
        "#{Fluxx.server_url}/api/rest/v1/#{@model_type.downcase}"
      end

      def auth_header
        { "Authorization" => "Bearer #{Fluxx.oauth_access_token}" }
      end
    end
  end
end