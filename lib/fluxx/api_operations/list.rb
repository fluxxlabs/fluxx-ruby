module Fluxx
  module ApiOperations
    module List
      def list(opts = {})
        response = request :list, options: opts
        model_type, resp_objects = response.delete('records').first
        ListObject.construct_from(model_type, { data: resp_objects }, response)
      end
    end
  end
end