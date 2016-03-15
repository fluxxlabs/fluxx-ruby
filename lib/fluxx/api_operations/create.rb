module Fluxx
  module ApiOperations
    module Create
      def create(attrs, opts = {})
        opts = opts.merge(@opts)
        response = request :create, data: attrs, options: opts
        ApiResource.construct_from @model_type, response[@model_type], opts
      end
    end
  end
end