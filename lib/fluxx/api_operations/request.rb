module Fluxx
  module ApiOperations
    module Request
      OPTIONS_TO_JSON = [:query, :filter, :sort, :page, :per_page, :style, :show_mavs, :enhanced_mavs, :relation].freeze

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
            options:    prepare_options(params[:options])
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

        def prepare_options(options)
          json_opts = options.clone.tap do |o|
            OPTIONS_TO_JSON.each { |key| o[key] = o[key].to_json if o[key] }
          end
          json_opts.keep_if { |key, value| OPTIONS_TO_JSON.include?(key) }
        end
      end

      protected

      def request(action, params)
        self.class.request(action, params)
      end
    end
  end
end
