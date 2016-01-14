module Fluxx
  module ApiOperations
    module Request
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def request(action, params)
          case Fluxx.protocol
          when :http
            Protocols::Http.new(
              action:     action,
              model_type: @model_type,
              model_id:   params[:model_id],
              data:       params[:data],
              options:    params[:options]
            ).request
          end
        end
      end
    end
  end
end