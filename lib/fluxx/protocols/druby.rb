module Fluxx
  module Protocols
    class DRuby

      ACTIONS = {
        list: {
          rest_api_method: :index
        },
        fetch: {
          rest_api_method: :get,
          requires_id: true
        },
        create: {
          rest_api_method: :create
        },
        update: {
          requires_id: true
        },
        destroy: {
          rest_api_method: :delete,
          requires_id: true
        }
      }.freeze

      def initialize(params)        
        @model_type  = params[:model_type]
        @model_id    = params[:model_id]
        @options     = params[:options]
        @action      = params[:action]
        @data        = params[:data]
        @drb_object  = Fluxx.drb_object 
      end

      def call
        raise(FluxxError, "DRuby not configured yet. Try Fluxx.connect_to_drb_server") if !@drb_object
        
        @drb_object.send rest_api_method, call_params
      end

      protected

      def rest_api_method
        action_info[:rest_api_method] || @action.to_sym
      end

      def action_info
        ACTIONS[@action] || raise(FluxxError, "not a valid action")
      end

      def call_params
        default_params.tap do |p|
          p[:params].merge!(id: @model_id) if action_info[:requires_id]
          p[:params].merge!(data: @data.to_json) if @data
          p[:params].merge!(@options) if @options
        end
      end

      def default_params
        {
          client_id: Fluxx.client_id,
          params: { model_type: @model_type }
        }
      end

    end
  end
end