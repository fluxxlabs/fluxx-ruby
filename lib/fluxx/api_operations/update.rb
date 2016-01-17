module Fluxx
  module ApiOperations
    module Update
      def save(params = {})
        update_attributes(params)
        params = params.reject { |k, _| respond_to?(k) }
        values = self.class.serialize_params(self).merge(params)
        return self if values.empty?
        
        response = self.request :update, model_id: @values[:id], data: values
        initialize_from response, {}
        self
      end
    end
  end
end