module Fluxx
  module ApiOperations
    module Update
      def save(opts = {})
        update({}, opts)
      end

      def update(attrs, opts = {})
        update_attributes(attrs)
        attrs = attrs.reject { |k, _| respond_to?(k) }
        values = self.class.serialize_params(self).merge(attrs)
        return self if values.empty?
        
        response = self.request :update, model_id: @values[:id], data: values, options: opts
        ApiResource.of_model_type(@model_type).construct_from response[@model_type], opts
      end
    end
  end
end