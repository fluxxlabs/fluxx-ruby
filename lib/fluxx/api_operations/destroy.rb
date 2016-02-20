module Fluxx
  module ApiOperations
    module Destroy
      def destroy(opts = {})
        opts = opts.merge(@opts)
        request :destroy, model_type: @model_type, model_id: @values[:id], options: opts
      end

      alias_method :delete, :destroy
    end
  end
end