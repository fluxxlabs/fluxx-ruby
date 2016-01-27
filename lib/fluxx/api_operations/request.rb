module Fluxx
  module ApiOperations
    module Request

      OPTIONS_TO_JSON = [:filter, :sort, :relation].freeze

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
          response = protocol_klass.new(params_for_protocol(action, params)).call
          parse_response response
        end

        protected

        def params_for_protocol(action, params)
          {
            action:     action,
            model_type: @model_type,
            model_id:   params[:model_id],
            data:       params[:data],
            options:    parse_options(params[:options])
          }
        end

        def parse_response(response)
          case response
          when 'true'
            true
          else
            JSON.parse(response)
          end
        end

        def parse_options(options)
          options.tap do |o|
            OPTIONS_TO_JSON.each { |key| o[key] = o[key].to_json if o[key] }
          end
        end
      end

      protected

      def request(action, params)
        self.class.request(action, params)
      end
    end
  end
end