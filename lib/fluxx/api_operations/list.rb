module Fluxx
  module ApiOperations
    module List
      def list(opts = {})
        response = request :list, options: opts
        model_type, resp_objects = response.delete('records').first
        response_opts = Util.symbolize_names(opts).merge Util.symbolize_names(response)
        ListObject.construct_from(model_type, { data: resp_objects }, response_opts)
      end
    end
  end
end