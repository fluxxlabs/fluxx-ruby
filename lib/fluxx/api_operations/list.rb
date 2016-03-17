module Fluxx
  module ApiOperations
    module List
      def list(opts = {})
        response = request :list, options: opts
        model_type, resp_objects = response.delete('records').first
        resp_opts = Util.symbolize_names(opts).merge Util.symbolize_names(response)
        ListObject.construct_from(model_type, { data: resp_objects }, resp_opts)
      end

      def all(opts = {})
        list_object = list(opts)
        api_resources = []
        list_object.auto_paging_each { |api_resource| api_resources << api_resource.instance_variable_get('@values') }
        ListObject.construct_from(list_object.model_type, { data: api_resources }, opts)
      end
    end
  end
end