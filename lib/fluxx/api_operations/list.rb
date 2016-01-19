module Fluxx
  module ApiOperations
    module List
      def list(opts = {})
        response = request :list, options: opts
        model_type, resp_objects = response['records'].first
        ListObject.construct_from(model_type, { data: resp_objects }, opts)
      end
    end
  end
end