module Fluxx
  module ApiOperations
    module Create
      def create(attrs, opts = {})
        opts = opts.merge(@opts) if defined?(@opts)
        response = request :create, data: attrs, options: opts

        if response["error"]
          ApiResource.construct_from(@model_type, attrs, opts).tap do |res|
            res.errors = JSON.parse(/\[.*\]/.match(response["error"]["message"])[0])
          end
        else
          ApiResource.construct_from @model_type, response.values.first, opts  
        end
      end
    end
  end
end