module Fluxx
  module ApiOperations
    module Create
      def create(attrs, opts = {})
        response = request :create, model_type: @model_type, data: attrs, options: opts
        ApiResource.of_model_type(@model_type).construct_from response[@model_type], opts
      end
    end
  end
end