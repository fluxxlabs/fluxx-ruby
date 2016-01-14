module Fluxx
  module ApiOperations
    module List
      def list(filters = {}, opts = {})
        opts = @opts.merge(opts) if @opts
        response = request :list, options: filters.merge(opts)
        model_type, resp_objects = response['records'].first
        obj = ListObject.of_model_type(model_type).construct_from({ data: resp_objects }, filters.merge(opts))
        obj.filters = filters.dup
        obj
      end
    end
  end
end