module Fluxx
  module ApiOperations
    module Fetch
      def fetch(id, opts = {})
        response = request :fetch, model_type: @model_type, model_id: id, options: opts
        ApiResource.of_model_type(@model_type).construct_from response[@model_type], opts
      end

      alias_method :find, :fetch
    end
  end
end