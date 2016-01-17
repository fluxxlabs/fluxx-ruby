module Fluxx
  module ApiOperations
    module Request

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def request(action, params)
          protocol_klass = case Fluxx.protocol
                           when :http
                             Protocols::Http
                           when :druby
                             Protocols::DRuby
                           else
                             raise FluxxError, "Protocol not supported. Try :http or :druby."
                           end
          protocol_klass.new(params_for_protocol(action, params)).call
        end

        protected

        def params_for_protocol(action, params)
          {
            action:     action,
            model_type: @model_type,
            model_id:   params[:model_id],
            data:       params[:data],
            options:    params[:options]
          }
        end
      end

      protected

      def request(action, params)
        self.class.request(action, params)
      end
    end
  end
end