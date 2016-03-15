module Fluxx
  module ApiOperations
    module Fetch
      def fetch(id, opts = {})
        response = request :fetch, model_id: id, options: opts
        ApiResource.construct_from @model_type, response[@model_type], opts
      end

      alias_method :find, :fetch
    end
  end
end