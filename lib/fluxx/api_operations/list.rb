module Fluxx
  module ApiOperations
    module List
      def list(opts = {})
        response = request :list, options: opts
        model_type, resp_objects = response['records'].first
        ListObject.of_model_type(model_type).construct_from({ data: resp_objects }, opts)
      end
    end
  end
end