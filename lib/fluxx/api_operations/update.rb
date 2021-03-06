module Fluxx
  module ApiOperations
    module Update
      def save
        if @original_values.nil?
          opts = @opts || {}
          response = self.request :create, data: @values, options: opts
          self.reset_from response.values.first, opts
        else
          update({})
        end
      end

      def update(attrs, opts = {})
        assign_attributes(attrs)
        attrs = attrs.reject { |k, _| respond_to?(k) }
        values = self.class.serialize_params(self).merge(attrs)
        return self if values.empty?
        
        opts = @opts.merge(opts) if @opts
        response = self.request :update, model_id: @values[:id], data: values, options: opts
        self.reset_from response.values.first, opts
      end

      alias_method :update_attributes, :update
    end
  end
end