module Fluxx
  module ApiOperations
    module Create
      def create(attrs, opts = {})
        opts = opts.merge(@opts) if @opts
        response = request :create, data: attrs, options: opts
        ApiResource.construct_from @model_type, response.values.first, opts
      end
    end
  end
end