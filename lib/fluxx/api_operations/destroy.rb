module Fluxx
  module ApiOperations
    module Destroy
      def destroy(opts = {})
        opts = opts.merge(@opts)
        if request :destroy, model_id: @values[:id], options: opts
          @values.freeze
        end
      end

      alias_method :delete, :destroy
    end
  end
end